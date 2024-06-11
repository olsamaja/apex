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
                Self.whenLoadingDetailsAndReviews(appId: appSummary.trackId, storeCode: appSummary.storeCode),
                Self.userAction(action: action.eraseToAnyPublisher())
            ]
        )
        .assign(to: \.state, on: self)
        .store(in: &cancellables)
    }
    
    func send(event: Event) {
        action.send(event)
    }
    
    static func whenLoadingDetailsAndReviews(appId: Int, storeCode: String) -> Feedback<State, Event> {

        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .loading = state else { return Empty().eraseToAnyPublisher() }

            let details = DataManager().getDetails(appId: appId, storeCode: storeCode)
                .map { DetailsRowModel(details: $0) }
                .map { SectionRowsModel.makeDetailsSectionModel(with: $0, isTappable: true) }

            let reviewsPublisher = DataManager().getReviews(appId: appId, storeCode: storeCode)
            
            let graph = reviewsPublisher
                .map { SectionRowsModel.makeGraphSectionModel(with: $0) }

            let reviews = reviewsPublisher
                .map { $0.map(ReviewRowModel.init) }
                .map { SectionRowsModel.makeReviewsSectionModel(with: $0, isTappable: true) }

            return Publishers.Zip3(details, graph, reviews)
                .map(Event.onLoaded)
                .catch { Just(Event.onFailedToLoadData($0)) }
                .eraseToAnyPublisher()
        }
    }
}
