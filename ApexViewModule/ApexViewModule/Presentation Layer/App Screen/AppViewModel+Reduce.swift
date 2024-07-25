//
//  AppViewModel+Reduce.swift
//  Apex
//
//  Created by Olivier Rigault on 07/01/2022.
//

import Combine
import ApexCore
import ApexNetwork

public extension AppViewModel {
    
    enum State {
        case idle
        case loadingDetails
        case detailsLoaded(SectionRowsModel)
        case loadingNextReviews([SectionRowsModel])
        case nextReviewsLoaded([SectionRowsModel])
        case error(DataError)
    }
    
    enum Event {
        case onAppear
        case onLoadingNextReviews([SectionRowsModel])
        case onDetailsLoaded(SectionRowsModel)
        case onNextReviewsloaded([SectionRowsModel])
        case onFailedToLoadData(DataError)
    }
}

extension AppViewModel.State: Equatable {
    public static func == (lhs: AppViewModel.State, rhs: AppViewModel.State) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle),
            (.loadingDetails, .loadingDetails),
            (.detailsLoaded, .detailsLoaded),
            (.loadingNextReviews, .loadingNextReviews),
            (.nextReviewsLoaded, .nextReviewsLoaded),
            (.error, .error):
            return true
        default:
            return false
        }
    }
}

extension AppViewModel {
    
    public static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .idle:
            return reduceIdle(state, event)
        case .loadingDetails:
            return reduceLoadingDetails(state, event)
        case .detailsLoaded:
            return reduceDetailsLoaded(state, event)
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
            return .loadingDetails
        default:
            return state
        }
    }
    
    static func reduceLoadingDetails(_ state: State, _ event: Event) -> State {
        switch event {
        case .onFailedToLoadData(let error):
            return .error(error)
        case .onDetailsLoaded(let details):
            return .detailsLoaded(details)
        default:
            return state
        }
    }

    static func reduceDetailsLoaded(_ state: State, _ event: Event) -> State {
        switch event {
        case .onLoadingNextReviews(let details):
            return .loadingNextReviews(details)
        default:
            return state
        }
    }
    
    static func reduceLoadingNextReviews(_ state: State, _ event: Event) -> State {
        switch event {
        case .onFailedToLoadData(let error):
            return .error(error)
        case .onNextReviewsloaded(let sections):
            return .nextReviewsLoaded(sections)
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

extension AppViewModel {
    static func userAction(action: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in action }
    }
}
