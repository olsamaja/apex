//
//  SearchAppsViewModel+Reduce.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 25/11/2021.
//

import Combine
import ApexNetwork
import ApexCore
import ApexReviewsModule

public extension SearchAppsViewModel {
    
    enum State {
        case idle
        case searching(String, AppStore)
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
        case search(String, AppStore)
        case select(Review)
        case clear
    }
}

extension SearchAppsViewModel.State: Equatable {
    public static func == (lhs: SearchAppsViewModel.State, rhs: SearchAppsViewModel.State) -> Bool {
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

extension SearchAppsViewModel {
    
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

extension SearchAppsViewModel {
    static func userAction(action: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in action }
    }
}
