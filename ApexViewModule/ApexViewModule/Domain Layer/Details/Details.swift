//
//  Details.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 02/11/2023.
//

import Foundation

public struct Details {
    
    public let trackId: Int
    public let trackName: String
    public let averageUserRating: Double
    public let version: String
    public let artworkUrl: URL?
    public let minimumOsVersion: String
    public let description: String
    public let sellerName: String
    public let fileSizeBytes: Int
    public let userRatingCount: Int

    public init(trackId: Int, 
                trackName: String,
                averageUserRating: Double,
                version: String,
                artworkUrl100: URL? = nil,
                minimumOsVersion: String,
                description: String,
                sellerName: String,
                fileSizeBytes: Int,
                userRatingCount: Int) {
        self.trackId = trackId
        self.trackName = trackName
        self.averageUserRating = averageUserRating
        self.version = version
        self.artworkUrl = artworkUrl100
        self.minimumOsVersion = minimumOsVersion
        self.description = description
        self.sellerName = sellerName
        self.fileSizeBytes = fileSizeBytes
        self.userRatingCount = userRatingCount
    }
}

extension Details: Equatable {}
