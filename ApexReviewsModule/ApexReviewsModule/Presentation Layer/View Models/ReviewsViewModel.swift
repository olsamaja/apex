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
                Self.whenLoading(appId: appSummary.trackId),
                Self.userAction(action: action.eraseToAnyPublisher())
            ]
        )
        .assign(to: \.state, on: self)
        .store(in: &cancellables)
    }
    
    func send(event: Event) {
        action.send(event)
    }
    
    static func whenLoading(appId: Int) -> Feedback<State, Event> {

        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            return Empty().eraseToAnyPublisher()
        }
    }
}
