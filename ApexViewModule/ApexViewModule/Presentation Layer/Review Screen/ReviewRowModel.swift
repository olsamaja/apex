//
//  ReviewRowViewModel.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 14/01/2022.
//

import Foundation
import ApexCore
import Algorithms

public struct ReviewRowModel: Identifiable {
    
    public let id: String
    public let review: Review
    
    init(review: Review) {
        self.id = UUID().uuidString
        self.review = review
    }
}

extension ReviewRowModel {
    
    var title: String { review.title }
    var author: String { review.author }
    var rating: String { review.rating }
    var content: String { review.content }
    var version: String { "v" + review.version }
    var updated: String { review.updated.toString() }

}

extension ReviewRowModel: Equatable {
    public static func == (lhs: ReviewRowModel, rhs: ReviewRowModel) -> Bool {
        lhs.review == rhs.review
    }
}

extension Array where Element == ReviewRowModel {
    
    func chunkedByMonth() -> [[ReviewRowModel]] {
        let chunked = self.chunked {
            Calendar.current.isDate($0.review.updated, equalTo: $1.review.updated, toGranularity: .month)
        }
        return chunked.map { Array($0) }
    }
}
