//
//  AppViewModel.swift
//  Apex
//
//  Created by Olivier Rigault on 04/01/2022.
//

import Combine
import ApexCore
import ApexNetwork

public final class AppViewModel: ObservableObject {
    
    public let appSummary: AppSummary
    @Published var state = State.idle
    
    private var cancellables = Set<AnyCancellable>()
    private let action = PassthroughSubject<Event, Never>()

    public init(appSummary: AppSummary, state: State = .idle) {
        self.appSummary = appSummary
        self.state = state
        setupFeedbacks()
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
                Self.whenLoadingAppDetailsAndReviews(appId: appSummary.trackId, storeCode: appSummary.storeCode),
                Self.userAction(action: action.eraseToAnyPublisher())
            ]
        )
        .assign(to: \.state, on: self)
        .store(in: &cancellables)
    }
    
    func send(event: Event) {
        action.send(event)
    }
    
    static func whenLoadingAppDetailsAndReviews(appId: Int, storeCode: String) -> Feedback<State, Event> {

        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .loading = state else { return Empty().eraseToAnyPublisher() }

            let appDetails = DataManager().getAppDetails(appId: appId, storeCode: storeCode)
                .map { AppDetailsRowViewModel(appDetails: $0) }
                .map { AppSectionModel.makeDetailsSectionModel(with: $0) }

            let reviews = DataManager().getReviews(appId: appId)
                .map { $0.map(AppReviewRowViewModel.init) }
                .map { AppSectionModel.makeReviewsSectionModel(with: $0) }

            return Publishers.Zip(appDetails, reviews)
                .map(Event.onLoaded)
                .catch { Just(Event.onFailedToLoadData($0)) }
                .eraseToAnyPublisher()
        }
    }
}
