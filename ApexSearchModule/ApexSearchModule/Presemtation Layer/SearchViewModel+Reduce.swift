//
//  SearchViewModel+Reduce.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 11/07/2021.
//

import Combine
import ApexNetwork
import ApexCore

public extension SearchViewModel {
    
    enum State {
        case idle
        case loading
        case loaded([SearchResultRowItem])
        case error(DataError)
    }
    
    enum Event {
        case onAppear
        case onDataLoaded([SearchResultRowItem])
        case onFailedToLoadData(DataError)
    }
}

extension SearchViewModel.State: Equatable {
    public static func == (lhs: SearchViewModel.State, rhs: SearchViewModel.State) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle),
             (.loading, .loading),
             (.loaded, .loaded),
             (.error, .error):
            return true
        default:
            return false
        }
    }
}

extension SearchViewModel {
    
    public static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .idle:
            return reduceIdle(state, event)
        case .loading:
            return reduceLoading(state, event)
        case .loaded:
            return reduceLoaded(state, event)
        case .error:
            return reduceError(state, event)
        }
    }
    
    static func reduceIdle(_ state: State, _ event: Event) -> State {
        switch event {
        case .onAppear:
            return .loading
        default:
            return state
        }
    }
    
    static func reduceLoading(_ state: State, _ event: Event) -> State {
        switch event {
        case .onFailedToLoadData(let error):
            return .error(error)
        case .onDataLoaded(let results):
            return .loaded(results)
        default:
            return state
        }
    }

    static func reduceLoaded(_ state: State, _ event: Event) -> State {
        return state
    }
    
    static func reduceError(_ state: State, _ event: Event) -> State {
        return state
    }
}

extension SearchViewModel {
    static func userAction(action: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in action }
    }
}
