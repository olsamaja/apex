//
//  SearchViewModel.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 10/07/2021.
//

import Combine
import ApexNetwork
import ApexCore

public final class SearchViewModel: ObservableObject {

    public let term: String
    @Published var state = State.idle
    
    private var cancellables = Set<AnyCancellable>()
    private let action = PassthroughSubject<Event, Never>()

    public init(term: String, state: State = .idle) {
        self.term = term
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
                Self.whenLoading(term: term),
                Self.userAction(action: action.eraseToAnyPublisher())
            ]
        )
        .assign(to: \.state, on: self)
        .store(in: &cancellables)
    }
    
    private func setupBindings() {
    }
    
    func send(event: Event) {
        action.send(event)
    }
    
    static func whenLoading(term: String) -> Feedback<State, Event> {

        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .loading = state else { return Empty().eraseToAnyPublisher() }
            
            return DataManager().search(with: term)
                .map { $0.map(SearchResultRowItem.init) }
                .map(Event.onDataLoaded)
                .catch { Just(Event.onFailedToLoadData($0)) }
                .eraseToAnyPublisher()
        }
    }

}
