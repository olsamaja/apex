//
//  ReviewRowItem.swift
//  ApexReviewsModule
//
//  Created by Olivier Rigault on 10/07/2021.
//

import Foundation

public struct ReviewRowItem: Identifiable {
    
    public let id: String
    let title: String
    let author: String
    let rating: String
    let content: String
    let version: String
    let updated: String
    
    init(review: Review) {
        self.id = UUID().uuidString
        self.title = review.title
        self.author = review.author
        self.rating = review.rating
        self.content = review.content
        self.version = "v" + review.version
        self.updated = review.updated.toString()
    }
}

extension ReviewRowItem: Equatable {}
