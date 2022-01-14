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
        case loadingReviews
        case loaded([AppSectionModel])
        case error(DataError)
    }
    
    enum Event {
        case onAppear
        case onLoadedReviews(AppSectionModel)
        case onFailedToLoadData(DataError)
    }
}

extension AppViewModel.State: Equatable {
    public static func == (lhs: AppViewModel.State, rhs: AppViewModel.State) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle),
             (.loadingReviews, .loadingReviews),
             (.loaded, .loaded),
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
        case .loadingReviews:
            return reduceLoadingReviews(state, event)
        case .loaded:
            return reduceLoaded(state, event)
        case .error:
            return reduceError(state, event)
        }
    }
    
    static func reduceIdle(_ state: State, _ event: Event) -> State {
        switch event {
        case .onAppear:
            return .loadingReviews
        default:
            return state
        }
    }
    
    static func reduceLoadingReviews(_ state: State, _ event: Event) -> State {
        switch event {
        case .onFailedToLoadData(let error):
            return .error(error)
        case .onLoadedReviews(let reviews):
            // If state == .loadedDetails(details), then return .loadedReviews(details + reviews)
            // In the mean time, just return reviews
            return .loaded([reviews])
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

extension AppViewModel {
    static func userAction(action: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in action }
    }
}

