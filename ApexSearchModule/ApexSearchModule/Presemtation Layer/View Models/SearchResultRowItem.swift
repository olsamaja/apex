//
//  SearchResultRowItem.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 11/07/2021.
//

import Foundation

public struct SearchResultRowItem: Identifiable {
    
    public let id: String
    let trackId: Int
    let trackName: String
    let sellerName: String
    let version: String
    let currentVersionReleaseDate: String
    let minimumOsVersion: String
    let averageUserRating: Double
    let userRatingCountForCurrentVersion: Int

    init(search: SearchResult) {
        self.id = UUID().uuidString
        self.trackId = search.trackId
        self.trackName = search.trackName
        self.sellerName = search.sellerName
        self.version = search.version
        self.currentVersionReleaseDate = search.currentVersionReleaseDate
        self.minimumOsVersion = search.minimumOsVersion
        self.averageUserRating = search.averageUserRating
        self.userRatingCountForCurrentVersion = search.userRatingCountForCurrentVersion
    }
    
    init(trackId: Int,
         trackName: String,
         sellerName: String,
         version: String,
         currentVersionReleaseDate: String,
         minimumOsVersion: String,
         averageUserRating: Double,
         userRatingCountForCurrentVersion: Int) {
        self.id = UUID().uuidString
        self.trackId = trackId
        self.trackName = trackName
        self.sellerName = sellerName
        self.version = version
        self.currentVersionReleaseDate = currentVersionReleaseDate
        self.minimumOsVersion = minimumOsVersion
        self.averageUserRating = averageUserRating
        self.userRatingCountForCurrentVersion = userRatingCountForCurrentVersion
    }
}

extension SearchResultRowItem: Equatable {}
