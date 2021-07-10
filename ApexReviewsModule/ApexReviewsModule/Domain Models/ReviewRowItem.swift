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
        self.version = review.version
        self.updated = review.updated
    }
    
    init(title: String, author: String, rating: String, content: String, version: String, updated: String) {
        self.id = UUID().uuidString
        self.title = title
        self.author = author
        self.rating = rating
        self.content = content
        self.version = version
        self.updated = updated
    }
}

extension ReviewRowItem: Equatable {}
