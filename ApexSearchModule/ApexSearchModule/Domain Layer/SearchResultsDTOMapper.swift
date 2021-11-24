//
//  SearchResultsDTOMapper.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 12/07/2021.
//

import Foundation
import ApexCore

public struct SearchResultsDTOMapper {
    
    static func map(_ dto: SearchResultsDTO, storeCode: String) -> [AppDetails] {
        dto.results.map {
            SearchResultDTOMapper.map($0, storeCode: storeCode)
        }
    }
}

struct SearchResultDTOMapper {
    
    static func map(_ dto: SearchResultDTO, storeCode: String) -> AppDetails {
        AppDetails(trackId: dto.trackId,
                   trackName: dto.trackName,
                   sellerName: dto.sellerName,
                   version: dto.version,
                   currentVersionReleaseDate: dto.currentVersionReleaseDate,
                   minimumOsVersion: dto.minimumOsVersion,
                   averageUserRating: dto.averageUserRating,
                   userRatingCountForCurrentVersion: dto.userRatingCountForCurrentVersion,
                   storeCode: storeCode)
    }
}
