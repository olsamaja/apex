//
//  ReviewsViewModel.swift
//  ApexReviewsModule
//
//  Created by Olivier Rigault on 10/07/2021.
//

import Combine
import ApexCore
import ApexNetwork

public final class ReviewsViewModel: ObservableObject {

    public let appDetails: AppDetails
    @Published var state = State.idle
    
    private var cancellables = Set<AnyCancellable>()
    private let action = PassthroughSubject<Event, Never>()

    public init(appDetails: AppDetails, state: State = .idle) {
        self.appDetails = appDetails
        self.state = state
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
                Self.whenLoading(appId: appDetails.trackId),
                Self.userAction(action: action.eraseToAnyPublisher())
            ]
        )
        .assign(to: \.state, on: self)
        .store(in: &cancellables)
    }
    
    private func setupBindings() {
    }
    
    func send(event: Event) {
        action.send(event)
    }
    
    static func whenLoading(appId: Int) -> Feedback<State, Event> {

        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .loading = state else { return Empty().eraseToAnyPublisher() }
            
            return DataManager().getReviews(appId: appId)
                .map { $0.map(ReviewRowItem.init) }
                .map(Event.onDataLoaded)
                .catch { Just(Event.onFailedToLoadData($0)) }
                .eraseToAnyPublisher()
        }
    }
}
