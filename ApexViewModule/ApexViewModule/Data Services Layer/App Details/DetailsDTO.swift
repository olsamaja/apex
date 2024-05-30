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
    
    private enum CodingKeys : String, CodingKey {
        case results = "results"
    }
    
    public init(trackId: Int, trackName: String, averageUserRating: Double, version: String, artworkUrl: URL?) {
        self.trackId = trackId
        self.trackName = trackName
        self.averageUserRating = averageUserRating
        self.version = version
        self.artworkUrl = artworkUrl
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
    }
}

public struct DetailsResultDTO: Decodable {
    let trackId: Int
    let trackName: String
    let averageUserRating: Double
    let version: String
    let artworkUrl100: String
}
