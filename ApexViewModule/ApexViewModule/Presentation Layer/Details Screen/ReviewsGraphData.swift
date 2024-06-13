//
//  GraphViewModel.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 05/06/2024.
//

import Foundation
import SwiftUI
import ApexCore

public struct ReviewsGraphData: Identifiable {
    
    public let id: String
    let endDate: Date
    let numberOfDays: Int
    let items: [ReviewGraphDataItem]
    
    init(endDate: Date, numberOfDays: Int, items: [ReviewGraphDataItem]) {
        self.id = UUID().uuidString
        self.endDate = endDate
        self.numberOfDays = numberOfDays
        self.items = items
    }
}

public class ReviewsGraphDataBuilder: BuilderProtocol {

    private var endDate: Date = Date()
    private var numberOfDays: Int = 7
    private var reviews: [Review] = []

    public init() {}
    
    public func withEndDate(_ endDate: Date) -> ReviewsGraphDataBuilder {
        self.endDate = endDate
        return self
    }
    
    public func withNumberOfDays(_ numberOfDays: Int) -> ReviewsGraphDataBuilder {
        self.numberOfDays = numberOfDays
        return self
    }
    
    public func withReviews(_ reviews: [Review]) -> ReviewsGraphDataBuilder {
        self.reviews = reviews
        return self
    }
    
    public func build() -> ReviewsGraphData {
        let filteredReviews = reviews.filter{ review in Calendar.current.isWithin(numberOfDays: numberOfDays, from: review.updated, and: endDate) }
        var graphDataItemsWithMissingDays = filteredReviews.map { ReviewGraphDataItem(review: $0, daysSinceEndDate: Calendar.current.numberOfDaysBetween($0.updated, and: endDate)) }
        let days = graphDataItemsWithMissingDays.map { $0.daysSinceEndDate }
        let allDays = Array(0...(numberOfDays - 1))
        let missingDays = allDays.filter { !days.contains($0) }
        for day in missingDays {
            graphDataItemsWithMissingDays.append(ReviewGraphDataItem(review: nil, daysSinceEndDate: day))
        }
        return ReviewsGraphData(endDate: endDate, numberOfDays: numberOfDays, items: graphDataItemsWithMissingDays)
    }
}

public struct ReviewGraphDataItem: Identifiable {
    
    public let id: String
    let review: Review?
    let daysSinceEndDate: Int
    
    init(review: Review?, daysSinceEndDate: Int) {
        self.id = UUID().uuidString
        self.review = review
        self.daysSinceEndDate = daysSinceEndDate
    }
    
    var ratingType: RatingType {
        if let review = review {
            RatingType(with: review.rating.toInt)
        } else {
            .none
        }
    }
    
    var weight: Int { (review == nil) ? 0 : 1 }
}

enum RatingType: String, CaseIterable {
    
    case positive = "Positive"
    case neutral = "Neutral"
    case negative = "Negative"
    case none = "None"

    var color: Color {
        switch self {
        case .positive:
            return .green
        case .neutral:
            return .yellow
        case .negative:
            return .red
        case .none:
            return .purple
        }
    }
    
    init(with rating: Int) {
        if rating > 3 { self = .positive }
        else if rating < 3 { self = .negative }
        else { self = .neutral }
    }
}
