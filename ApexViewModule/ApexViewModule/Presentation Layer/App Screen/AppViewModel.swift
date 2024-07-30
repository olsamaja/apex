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
                Self.whenLoadingDetails(appId: appSummary.trackId, storeCode: appSummary.storeCode),
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
    
    static func whenLoadingDetails(appId: Int, storeCode: String) -> Feedback<State, Event> {
        
        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .loadingDetails = state else { return Empty().eraseToAnyPublisher() }
            
            let details = DataManager().getDetails(appId: appId, storeCode: storeCode)
                .map { DetailsRowModel(details: $0) }
                .map { SectionRowsModel.makeDetailsSectionModel(with: $0, isTappable: true) }
            
            return details
                .map(Event.onDetailsLoaded)
                .catch { Just(Event.onFailedToLoadData($0)) }
                .eraseToAnyPublisher()
        }
    }
    
    static func whenLoadingNextReviews(appId: Int, storeCode: String) -> Feedback<State, Event> {
        
        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .loadingNextReviews(let detailsSectionRowModel, _, let reviewSectionRowModels) = state else { return Empty().eraseToAnyPublisher() }
            
            let reviewsPublisher = DataManager().getReviews(appId: appId, storeCode: storeCode)
            
            let sections = reviewsPublisher
                .map {
                    let reviews = reviewSectionRowModels.flattenedReviews + $0
                    let graph = SectionRowsModel.makeGraphSectionModel(with: reviews)
                    let stars = SectionRowsModel.makeStarsSectionModel(with: reviews)
                    let reviewRowModels = reviews.map { ReviewRowModel.init(review: $0) }
                    let reviewsPerMonth = SectionRowsModel.makeReviewsSectionModelsPerMonth(with: reviewRowModels, isTappable: true)
                    return (details: detailsSectionRowModel, graphs: [graph] + [stars], reviews: reviewsPerMonth)
                }
            
            return sections
                .map(Event.onNextReviewsloaded)
                .catch { Just(Event.onFailedToLoadData($0)) }
                .eraseToAnyPublisher()
        }
    }
}

extension Array where Element == SectionRowsModel {
    
    var flattenedReviews: [Review] {
        let reviewSectionRowModels = self.filter { $0.category == .reviews }
        let contentRowModels = reviewSectionRowModels.compactMap { $0.rows }
        let flattenedContentRowModels = contentRowModels.reduce([], +)
        let reviews: [Review?] = flattenedContentRowModels.map {
            if case let ContentRowModel.Category.review(reviewRowModel) = $0.category { reviewRowModel.review } else { nil }
        }
        
        return reviews.compactMap { $0 }
    }
}
