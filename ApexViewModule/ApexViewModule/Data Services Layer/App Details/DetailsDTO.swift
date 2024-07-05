//
//  AppDetailsDTO.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 01/11/2023.
//

import Foundation
import ApexCore

public struct DetailsDTO: Decodable {
    
    let trackId: Int
    let trackName: String
    let averageUserRating: Double
    let version: String
    let artworkUrl: URL?
    let minimumOsVersion: String
    let description: String
    let sellerName: String
    let fileSizeBytes: String
    let userRatingCount: Int
    let releaseNotes: String
    let releaseDate: Date

    private enum CodingKeys : String, CodingKey {
        case results = "results"
    }
    
    public init(trackId: Int, 
                trackName: String,
                averageUserRating: Double,
                version: String,
                artworkUrl: URL?,
                minimumOsVersion: String,
                description: String,
                sellerName: String,
                fileSizeBytes: String,
                userRatingCount: Int,
                releaseNotes: String,
                releaseDate: Date) {
        self.trackId = trackId
        self.trackName = trackName
        self.averageUserRating = averageUserRating
        self.version = version
        self.artworkUrl = artworkUrl
        self.minimumOsVersion = minimumOsVersion
        self.description = description
        self.sellerName = sellerName
        self.fileSizeBytes = fileSizeBytes
        self.userRatingCount = userRatingCount
        self.releaseNotes = releaseNotes
        self.releaseDate = releaseDate
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let results = try container.decode([DetailsResultDTO].self, forKey: CodingKeys.results)
        
        guard let first = results.first else {
            throw DataError.parsing(description: "App details data missing in payload.")
        }
        
        trackId = first.trackId
        trackName = first.trackName
        averageUserRating = first.averageUserRating
        version = first.version
        artworkUrl = URL(string: first.artworkUrl100)
        minimumOsVersion = first.minimumOsVersion
        description = first.description
        sellerName = first.sellerName
        fileSizeBytes = first.fileSizeBytes
        userRatingCount = first.userRatingCount
        releaseNotes = first.releaseNotes
        
        let releaseDateString = first.releaseDate
        let dateFormatter = ISO8601DateFormatter()
        releaseDate = dateFormatter.date(from: releaseDateString) ?? Date()
    }
}

public struct DetailsResultDTO: Decodable {
    let trackId: Int
    let trackName: String
    let averageUserRating: Double
    let version: String
    let artworkUrl100: String
    let minimumOsVersion: String
    let description: String
    let sellerName: String
    let fileSizeBytes: String
    let userRatingCount: Int
    let releaseNotes: String
    let releaseDate: String
}
