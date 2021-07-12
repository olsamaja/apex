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

struct SearchResultDTO: Decodable {
    let trackName: String
    let trackId: Int
    let sellerName: String
    let version: String
    let currentVersionReleaseDate: String
    let minimumOsVersion: String
    let averageUserRating: Double
}
