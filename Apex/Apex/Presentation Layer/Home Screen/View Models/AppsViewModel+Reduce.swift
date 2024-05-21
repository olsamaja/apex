//
//  AppsViewModel+Reduce.swift
//  Apex
//
//  Created by Olivier Rigault on 10/12/2021.
//

import Combine
import ApexCore

public extension AppsViewModel {
    
    enum State {
        case idle
        case loading
        case loaded([AppRowModel])
        case error(DataError)
    }
    
    enum Event {
        case onAppear
        case onRefresh
        case onDataLoaded([AppRowModel])
        case onFailedToLoadData(DataError)
        case onPerform(UserAction)
    }
    
    enum UserAction {
        case clearSearch
    }
}

extension AppsViewModel.State: Equatable {
    public static func == (lhs: AppsViewModel.State, rhs: AppsViewModel.State) -> Bool {
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

extension AppsViewModel {
    
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
        case .onDataLoaded(let apps):
            return .loaded(apps)
        default:
            return state
        }
    }

    static func reduceLoaded(_ state: State, _ event: Event) -> State {
        switch event {
        case .onRefresh:
            return .loading
        default:
            return state
        }
    }
    
    static func reduceError(_ state: State, _ event: Event) -> State {
        return state
    }
}

extension AppsViewModel {
    static func userAction(action: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in action }
    }
}
