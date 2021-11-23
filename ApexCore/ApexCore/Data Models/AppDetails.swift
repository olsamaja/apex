//
//  AppDetails.swift
//  ApexCore
//
//  Created by Olivier Rigault on 22/11/2021.
//

import Foundation

public struct AppDetails {
    
    public let trackId: Int
    public let trackName: String
    public let sellerName: String
    public let version: String
    public let currentVersionReleaseDate: Date
    public let minimumOsVersion: String
    public let averageUserRating: Double
    public let userRatingCountForCurrentVersion: Int
    
    public init(
        trackId: Int,
        trackName: String,
        sellerName: String,
        version: String,
        currentVersionReleaseDate: Date,
        minimumOsVersion: String,
        averageUserRating: Double,
        userRatingCountForCurrentVersion: Int
    ) {
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

extension AppDetails: Equatable {}
