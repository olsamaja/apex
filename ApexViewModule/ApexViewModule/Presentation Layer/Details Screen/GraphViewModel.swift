//
//  GraphViewModel.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 05/06/2024.
//

import Foundation
import SwiftUI

public struct GraphViewModel: Identifiable {
    
    public let id: String
    public let reviews: [Review]
    public let numberOfDays: Int
    
    public var reviewData: [ReviewData] {
        reviews.map (ReviewData.init)
    }
    
    public init(reviews: [Review], numberOfDays: Int) {
        self.id = UUID().uuidString
        self.reviews = reviews
        self.numberOfDays = numberOfDays
    }
}

public struct ReviewData: Identifiable {
    
    public let id: String
    let date: Date
    let author: String
    let ratings: Int
    let ratingType: RatingType
    
    public var dateOfDay: Date {
        let dateFormatter = ISO8601DateFormatter()
        var dateStringWithoutFraction = date.formatted(.iso8601
            .year()
            .month()
            .day()
        )
        
        dateStringWithoutFraction += "T00:00:00-00:00"
         return dateFormatter.date(from: dateStringWithoutFraction) ?? date
    }
        
    init(review: Review) {
        self.id = UUID().uuidString
        self.date = review.updated
        self.author = review.author
        self.ratings = 1
        self.ratingType = RatingType(with: review.rating.toInt)
    }
}

enum RatingType: String, CaseIterable {
    
    case positive = "Positive"
    case neutral = "Neutral"
    case negative = "Negative"

    var color: Color {
        switch self {
        case .positive:
            return .green
        case .neutral:
            return .yellow
        case .negative:
            return .red
        }
    }
    
    init(with rating: Int) {
        if rating > 3 { self = .positive }
        else if rating < 3 { self = .negative }
        else { self = .neutral }
    }
}
