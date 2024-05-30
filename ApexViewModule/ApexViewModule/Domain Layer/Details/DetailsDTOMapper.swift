//
//  DetailsDTOMapper.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 02/11/2023.
//

import Foundation
import ApexCore

public struct DetailsDTOMapper {
    
    static func map(_ dto: DetailsDTO) -> Details {
        Details(trackId: dto.trackId,
                trackName: dto.trackName,
                averageUserRating: dto.averageUserRating,
                version: dto.version,
                artworkUrl100: dto.artworkUrl)
    }
}
