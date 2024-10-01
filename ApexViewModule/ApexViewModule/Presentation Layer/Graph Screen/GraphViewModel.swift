//
//  GraphViewModel.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 20/08/2024.
//

import Combine
import ApexCore
import ApexNetwork

public final class GraphViewModel: ObservableObject {
    
    public var appSummary: AppSummary
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
                Self.whenLoadingNextReviews(appId: appSummary.trackId, storeCode: appSummary.storeCode),
                Self.userAction(action: action.eraseToAnyPublisher())
            ]
        )
        .assign(to: \.state, on: self)
        .store(in: &cancellables)
    }

    func send(event: Event) {
        action.send(event)
    }
    
    static func whenLoadingNextReviews(appId: Int, storeCode: String) -> Feedback<State, Event> {
        
        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .loadingNextReviews(_, let loadedReviews) = state else { return Empty().eraseToAnyPublisher() }
            
            let reviewsPublisher = DataManager().getReviews(appId: appId, storeCode: storeCode)
            
            let sections = reviewsPublisher
                .map {
                    let reviews = loadedReviews + $0
                    let graph = SectionRowsModel.makeGraphSectionModel(with: reviews)
                    let stars = SectionRowsModel.makeStarsSectionModel(with: reviews)
                    return (graphs: [graph] + [stars], reviews: reviews)
                }
            
            return sections
                .map(Event.onNextReviewsloaded)
                .catch { Just(Event.onFailedToLoadData($0)) }
                .eraseToAnyPublisher()
        }
    }

}
