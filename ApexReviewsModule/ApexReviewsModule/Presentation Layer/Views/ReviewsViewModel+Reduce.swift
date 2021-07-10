//
//  ReviewsViewModel+Reduce.swift
//  ApexReviewsModule
//
//  Created by Olivier Rigault on 10/07/2021.
//

import Combine
import ApexCore
import ApexNetwork

public extension ReviewsViewModel {
    
    enum State {
        case idle
        case loading
        case loaded([ReviewRowItem])
        case error(DataError)
    }
    
    enum Event {
        case onAppear
        case onDataLoaded([ReviewRowItem])
        case onFailedToLoadData(DataError)
    }
}

extension ReviewsViewModel.State: Equatable {
    public static func == (lhs: ReviewsViewModel.State, rhs: ReviewsViewModel.State) -> Bool {
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

extension ReviewsViewModel {
    
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
        case .onDataLoaded(let tracks):
            return .loaded(tracks)
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

extension ReviewsViewModel {
    static func userAction(action: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in action }
    }
}
