//
//  ReviewRowViewModel.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 14/01/2022.
//

import Foundation

public struct ReviewRowModel: Identifiable {
    
    public let id: String
    private let review: Review
    
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
