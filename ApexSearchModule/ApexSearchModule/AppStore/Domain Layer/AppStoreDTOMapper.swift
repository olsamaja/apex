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
    
    static func map(_ store: AppStore) -> AppStoreDTO {
        AppStoreDTO(code: store.code, name: store.name)
    }
}
