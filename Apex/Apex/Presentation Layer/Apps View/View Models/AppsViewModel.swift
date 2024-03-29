//
//  AppsViewModel.swift
//  Apex
//
//  Created by Olivier Rigault on 24/11/2021.
//

import Combine
import ApexCore
import ApexNetwork

public final class AppsViewModel: ObservableObject {

    @Published var state = State.idle
    @Published var term = ""
    @Published var favorites = AppFavorites()
    
    private var cancellables = Set<AnyCancellable>()
    private let action = PassthroughSubject<Event, Never>()

    public init(state: State = .idle) {
        self.state = state
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
    
    private func setupBindings() {}
    
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
            
            return DataManager().loadFavorites()
                .map { $0.map(AppRowItem.init) }
                .map(Event.onDataLoaded)
                .catch { Just(Event.onFailedToLoadData($0)) }
                .eraseToAnyPublisher()
        }
    }
}

extension DataManager {
    
    func loadFavorites() -> AnyPublisher<[AppSummary], DataError> {
        return Just(AppFavorites.shared.allFavorites)
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}
