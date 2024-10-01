//
//  GraphViewModel+Reduce.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 20/08/2024.
//

import Combine
import ApexCore
import ApexNetwork

public extension GraphViewModel {
    
    enum State {
        case idle
        case loadingNextReviews([SectionRowsModel], [Review])
        case nextReviewsLoaded([SectionRowsModel], [Review])
        case error(DataError)
    }
    
    enum Event {
        case onAppear
        case onLoadingNextReviews([SectionRowsModel], [Review])
        case onNextReviewsloaded([SectionRowsModel], [Review])
        case onFailedToLoadData(DataError)
    }
}

extension GraphViewModel.State: Equatable {
    public static func == (lhs: GraphViewModel.State, rhs: GraphViewModel.State) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle),
            (.loadingNextReviews, .loadingNextReviews),
            (.nextReviewsLoaded, .nextReviewsLoaded),
            (.error, .error):
            return true
        default:
            return false
        }
    }
}

extension GraphViewModel {
    
    public static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .idle:
            return reduceIdle(state, event)
        case .loadingNextReviews:
            return reduceLoadingNextReviews(state, event)
        case .nextReviewsLoaded:
            return reduceNextReviewsLoaded(state, event)
        case .error:
            return reduceError(state, event)
        }
    }
    
    static func reduceIdle(_ state: State, _ event: Event) -> State {
        switch event {
        case .onAppear:
            return .loadingNextReviews([], [])
        default:
            return state
        }
    }
    
    static func reduceLoadingNextReviews(_ state: State, _ event: Event) -> State {
        switch event {
        case .onFailedToLoadData(let error):
            return .error(error)
        case .onNextReviewsloaded(let graphs, let reviews):
            return .nextReviewsLoaded(graphs, reviews)
        default:
            return state
        }
    }

    static func reduceNextReviewsLoaded(_ state: State, _ event: Event) -> State {
        return state
    }

    static func reduceError(_ state: State, _ event: Event) -> State {
        return state
    }
}

extension GraphViewModel {
    static func userAction(action: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in action }
    }
}
