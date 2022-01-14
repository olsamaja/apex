//
//  Review.swift
//  ApexReviewsModule
//
//  Created by Olivier Rigault on 09/07/2021.
//

import Foundation

public struct Review {
    
    public let title: String
    public let author: String
    public let rating: String
    public let content: String
    public let version: String
    public let updated: Date
    
    public init(title: String, author: String, rating: String, content: String, version: String, updated: Date) {
        self.title = title
        self.author = author
        self.rating = rating
        self.content = content
        self.version = version
        self.updated = updated
    }
}
