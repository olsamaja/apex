//
//  ReviewsByStarData.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 28/06/2024.
//

import Foundation
import SwiftUI
import ApexCore

public struct ReviewsByStarData: Identifiable {
    
    public let id: String
    let numberOfReviews: Int
    let items: [ReviewByStarDataItem]
    
    var averageRating: String {
        let totalNumberOfReviews = items.map { $0.numberOfReviews }.reduce(0, +)
        let totalWeight = items.map { $0.numberOfReviews * $0.rating.toInt }.reduce(0, +)
        return String(format: "%0.1f", Double(totalWeight) / Double(totalNumberOfReviews))
    }
    
    init(numberOfReviews: Int, items: [ReviewByStarDataItem]) {
        self.id = UUID().uuidString
        self.numberOfReviews = numberOfReviews
        self.items = items
    }
}

public class ReviewsByStarGraphDataBuilder: BuilderProtocol {

    private var endDate: Date = Date()
    private var numberOfDays: Int = 7
    private var reviews: [Review] = []

    public init() {}
    
    public func withEndDate(_ endDate: Date) -> ReviewsByStarGraphDataBuilder {
        self.endDate = endDate
        return self
    }
    
    public func withNumberOfDays(_ numberOfDays: Int) -> ReviewsByStarGraphDataBuilder {
        self.numberOfDays = numberOfDays
        return self
    }
    
    public func withReviews(_ reviews: [Review]) -> ReviewsByStarGraphDataBuilder {
        self.reviews = reviews
        return self
    }
    
    public func build() -> ReviewsByStarData {
        let filteredReviews = reviews.filter{ review in Calendar.current.isWithin(numberOfDays: numberOfDays, from: review.updated, and: endDate) }
        
        let fiveStarsReviewsCount = filteredReviews.filter { $0.rating == "5" }.count
        let fourStarsReviewsCount = filteredReviews.filter { $0.rating == "4" }.count
        let threeStarsReviewsCount = filteredReviews.filter { $0.rating == "3" }.count
        let twoStarsReviewsCount = filteredReviews.filter { $0.rating == "2" }.count
        let oneStarsReviewsCount = filteredReviews.filter { $0.rating == "1" }.count
        
        let graphDataItems = [ReviewByStarDataItem(rating: "5", numberOfReviews: fiveStarsReviewsCount),
                              ReviewByStarDataItem(rating: "4", numberOfReviews: fourStarsReviewsCount),
                              ReviewByStarDataItem(rating: "3", numberOfReviews: threeStarsReviewsCount),
                              ReviewByStarDataItem(rating: "2", numberOfReviews: twoStarsReviewsCount),
                              ReviewByStarDataItem(rating: "1", numberOfReviews: oneStarsReviewsCount)]

        let numberOfReviews = graphDataItems.map { $0.numberOfReviews }.reduce(0, +)

        return ReviewsByStarData(numberOfReviews: numberOfReviews, items: graphDataItems)
    }
}

public struct ReviewByStarDataItem: Identifiable {
    
    public let id: String
    let rating: String
    let numberOfReviews: Int
    
    init(rating: String, numberOfReviews: Int) {
        self.id = UUID().uuidString
        self.rating = rating
        self.numberOfReviews = numberOfReviews
    }
}
