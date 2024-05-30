//
//  AppsViewModel.swift
//  Apex
//
//  Created by Olivier Rigault on 24/11/2021.
//

import SwiftUI
import Combine
import ApexCore
import ApexNetwork

public final class AppsViewModel: ObservableObject {

    @Binding var storedApps: StoredApps
    @Published var state = State.idle
    @Published var term = ""

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

    func search(with term: String) {
        OLLogger.info("Search term: \(term)")
        self.term = term
    }
    
    static func whenLoading() -> Feedback<State, Event> {

        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .loading = state else { return Empty().eraseToAnyPublisher() }
            
            return DataManager().loadStoredApps()
                .map { $0.map(AppRowModel.init) }
                .map(Event.onDataLoaded)
                .catch { Just(Event.onFailedToLoadData($0)) }
                .eraseToAnyPublisher()
        }
    }
}

extension DataManager {
    
    func loadStoredApps() -> AnyPublisher<[AppSummary], DataError> {
        return Just(StoredApps().all)
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}
