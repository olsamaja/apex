//
//  AppStoreDTOMapper.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 25/11/2021.
//

import Foundation

public struct AppStoreDTOMapper {
    
    static func map(_ dto: AppStoreDTO) -> AppStore {
        AppStore(code: dto.code, name: dto.name)
    }
}
