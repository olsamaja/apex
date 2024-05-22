//
//  HomeViewModel.swift
//  Apex
//
//  Created by Olivier Rigault on 21/05/2024.
//

import SwiftUI
import Combine
import ApexCore
import ApexNetwork

public final class HomeViewModel: ObservableObject {
    
    @Published var state = State.idle
    @Binding var storedApps: StoredApps

    private var cancellables = Set<AnyCancellable>()
    private let action = PassthroughSubject<Event, Never>()

    public init(state: State = .idle, storedApps: Binding<StoredApps>) {
        self.state = state
        _storedApps = storedApps
        setupFeedbacks()
        setupBindings()
    }

    deinit {
        cancellables.removeAll()
    }
    
    private func setupFeedbacks() {
        Publishers.system(
            initial: state,
            reduce: Self.reduce,
            scheduler: RunLoop.main,
            feedbacks: [
                Self.whenLoading(),
                Self.userAction(action: action.eraseToAnyPublisher())
            ]
        )
        .assign(to: \.state, on: self)
        .store(in: &cancellables)
    }
    
    private func setupBindings() {
        let _ = storedApps.$apps
            .sink(receiveValue: { [weak self] (_) in
                guard let self = self else { return }
                self.send(event: .onRefresh)
            })
        .store(in: &cancellables)
    }
    
    func send(event: Event) {
        action.send(event)
    }

    static func whenLoading() -> Feedback<State, Event> {

        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .loading = state else { return Empty().eraseToAnyPublisher() }
            
            return DataManager().loadFavoriteApps()
                .map { $0.map(AppRowModel.init) }
                .map(Event.onDataLoaded)
                .catch { Just(Event.onFailedToLoadData($0)) }
                .eraseToAnyPublisher()
        }
    }
}

extension DataManager {
    
    func loadFavoriteApps() -> AnyPublisher<[AppSummary], DataError> {
        return Just(StoredApps().favorites)
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}
