//
//  AppDetailsDTO.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 01/11/2023.
//

import Foundation
import ApexCore

public struct AppDetailsDTO: Decodable {
    
    let trackId: Int
    let trackName: String
    let averageUserRating: Double
    let version: String
    
    private enum CodingKeys : String, CodingKey {
        case results = "results"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let results = try container.decode([AppDetailsResultDTO].self, forKey: CodingKeys.results)
        
        guard let first = results.first else {
            throw DataError.parsing(description: "App details data missing in payload.")
        }
        
        trackId = first.trackId
        trackName = first.trackName
        averageUserRating = first.averageUserRating
        version = first.version
    }
}

public struct AppDetailsResultDTO: Decodable {
    let trackId: Int
    let trackName: String
    let averageUserRating: Double
    let version: String
}
