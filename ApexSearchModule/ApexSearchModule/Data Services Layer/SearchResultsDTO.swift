//
//  SearchResultsDTO.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 12/07/2021.
//

import Foundation

public struct SearchResultsDTO: Decodable {
    let results: [SearchResultDTO]
}

struct SearchResultDTO {
    let trackName: String
    let trackId: Int
    let sellerName: String
    let version: String
    let currentVersionReleaseDate: Date
    let minimumOsVersion: String
    let averageUserRating: Double
    let userRatingCountForCurrentVersion: Int
}

extension SearchResultDTO: Decodable {
    
    private enum CodingKeys : String, CodingKey {
        case trackName = "trackName"
        case trackId = "trackId"
        case version = "version"
        case sellerName = "sellerName"
        case currentVersionReleaseDate = "currentVersionReleaseDate"
        case minimumOsVersion = "minimumOsVersion"
        case averageUserRating = "averageUserRating"
        case userRatingCountForCurrentVersion = "userRatingCountForCurrentVersion"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        trackName = try container.decode(String.self, forKey: CodingKeys.trackName)
        trackId = try container.decode(Int.self, forKey: CodingKeys.trackId)
        sellerName = try container.decode(String.self, forKey: CodingKeys.sellerName)
        version = try container.decode(String.self, forKey: CodingKeys.version)
        minimumOsVersion = try container.decode(String.self, forKey: CodingKeys.minimumOsVersion)
        averageUserRating = try container.decode(Double.self, forKey: CodingKeys.averageUserRating)
        userRatingCountForCurrentVersion = try container.decode(Int.self, forKey: CodingKeys.userRatingCountForCurrentVersion)

        let releaseDateString = try container.decode(String.self, forKey: CodingKeys.currentVersionReleaseDate)
        let dateFormatter = ISO8601DateFormatter()
        currentVersionReleaseDate = dateFormatter.date(from: releaseDateString) ?? Date()
    }
}
