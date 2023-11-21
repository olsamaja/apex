//
//  SearchApplicationsViewModel.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 10/11/2023.
//

import Combine
import ApexNetwork
import ApexCore
import ApexStoreModule

public final class SearchApplicationsViewModel: ObservableObject {

    let store: Store
    @Published var state = State.idle
    @Published var term = ""

    private var cancellables = Set<AnyCancellable>()
    private let action = PassthroughSubject<Event, Never>()

    public init(state: State = .idle) {
        self.state = state
        self.store = Store(code: "GB", name: "United Kingdom")
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
                Self.whenSearching(),
                Self.userAction(action: action.eraseToAnyPublisher())
            ]
        )
        .assign(to: \.state, on: self)
        .store(in: &cancellables)
    }
    
    private func setupBindings() {
        
        let searchPublisher = $term
                .dropFirst(1)
                .debounce(for: 1, scheduler: RunLoop.main)
                .removeDuplicates()
        
        searchPublisher
            .filter { $0.count > 2 }
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] (term) in
                guard let self = self else { return }
                self.send(event: .onPerform(.search(term, self.store)))
            })
        .store(in: &cancellables)
        
        searchPublisher
            .filter { $0.count == 0 }
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] (_) in
                self?.send(event: .onPerform(.clear))
            })
        .store(in: &cancellables)
    }
    
    func send(event: Event) {
        action.send(event)
    }
    
    func search(with term: String) {
        self.term = term
    }
    
    static func whenSearching() -> Feedback<State, Event> {

        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .searching(let term, let store) = state else { return Empty().eraseToAnyPublisher() }
            
            return DataManager().search(with: term, storeCode: store.code)
                .map { $0.map(SearchResultRowItem.init) }
                .map(Event.onDataLoaded)
                .catch { Just(Event.onFailedToLoadData($0)) }
                .eraseToAnyPublisher()
        }
    }
}

extension SearchApplicationsViewModel {
    static func userAction(action: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in action }
    }
}
