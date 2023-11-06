//
//  AppDetailsDTOMapper.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 02/11/2023.
//

import Foundation
import ApexCore

public struct AppDetailsDTOMapper {
    
    static func map(_ dto: AppDetailsDTO) -> AppDetails {
        AppDetails(trackId: dto.trackId,
                   trackName: dto.trackName,
                   averageUserRating: dto.averageUserRating,
                   version: dto.version)
    }
}
