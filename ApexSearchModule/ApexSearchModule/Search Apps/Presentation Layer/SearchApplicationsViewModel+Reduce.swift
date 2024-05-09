//
//  SearchApplicationsViewModel+Reduce.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 11/11/2023.
//

import Combine
import ApexNetwork
import ApexCore
import ApexStoreModule

public extension SearchApplicationsViewModel {
    
    enum State {
        case idle
        case searching(String, Store)
        case loaded([SearchResultRowItem])
        case error(DataError)
    }
    
    enum Event {
        case onAppear
        case onDataLoaded([SearchResultRowItem])
        case onFailedToLoadData(DataError)
        case onPerform(UserAction)
    }
    
    enum UserAction {
        case search(String, Store)
        case clear
    }
}

extension SearchApplicationsViewModel.State: Equatable {
    public static func == (lhs: SearchApplicationsViewModel.State, rhs: SearchApplicationsViewModel.State) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle),
             (.loaded, .loaded),
             (.error, .error):
            return true
        case (let .searching(term1, store1), let .searching(term2, store2)):
            return term1 == term2 && store1 == store2
        default:
            return false
        }
    }
}

extension SearchApplicationsViewModel {
    
    public static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .idle:
            return reduceIdle(state, event)
        case .searching:
            return reduceSearching(state, event)
        case .loaded:
            return reduceLoaded(state, event)
        case .error:
            return reduceError(state, event)
        }
    }
    
    static func reduceIdle(_ state: State, _ event: Event) -> State {
        switch event {
        case .onPerform(.search(let term, let store)):
            return .searching(term, store)
        default:
            return state
        }
    }
    
    static func reduceSearching(_ state: State, _ event: Event) -> State {
        switch event {
        case .onFailedToLoadData(let error):
            return .error(error)
        case .onDataLoaded(let artists):
            return .loaded(artists)
        default:
            return state
        }
    }

    static func reduceLoaded(_ state: State, _ event: Event) -> State {
        switch event {
        case .onPerform(.search(let term, let store)):
            return .searching(term, store)
        case .onPerform(.clear):
            return .idle
        default:
            return state
        }
    }
    
    static func reduceError(_ state: State, _ event: Event) -> State {
        return state
    }
}
