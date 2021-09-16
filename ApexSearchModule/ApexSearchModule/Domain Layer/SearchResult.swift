//
//  SearchResult.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 11/07/2021.
//

import Foundation

struct SearchResult {
    let trackName: String
    let trackId: Int
    let sellerName: String
    let version: String
    let currentVersionReleaseDate: String
    let minimumOsVersion: String
    let averageUserRating: Double
    let userRatingCountForCurrentVersion: Int
}
