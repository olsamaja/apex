//
//  SearchResultsDTOMapper.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 12/07/2021.
//

import Foundation

public struct SearchResultsDTOMapper {
    
    static func map(_ dto: SearchResultsDTO) -> [SearchResult] {
        dto.results.map {
            SearchResultDTOMapper.map($0)
        }
    }
}

struct SearchResultDTOMapper {
    
    static func map(_ dto: SearchResultDTO) -> SearchResult {
        SearchResult(trackName: dto.trackName,
                     trackId: dto.trackId,
                     sellerName: dto.sellerName,
                     version: dto.version,
                     currentVersionReleaseDate: dto.currentVersionReleaseDate,
                     minimumOsVersion: dto.minimumOsVersion,
                     averageUserRating: dto.averageUserRating,
                     userRatingCountForCurrentVersion: dto.userRatingCountForCurrentVersion)
    }
}
