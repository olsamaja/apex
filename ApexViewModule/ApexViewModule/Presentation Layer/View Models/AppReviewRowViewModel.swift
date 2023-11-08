//
//  AppReviewRowViewModel.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 14/01/2022.
//

import Foundation

public struct AppReviewRowViewModel: Identifiable, Hashable {
    
    public let id: String
    public let title: String
    public let author: String
    public let rating: String
    public let content: String
    public let version: String
    public let updated: String
    
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

extension AppReviewRowViewModel: Equatable {}
