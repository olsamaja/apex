//
//  StoresDTOMapper.swift
//  ApexStoreModule
//
//  Created by Olivier Rigault on 19/11/2021.
//

import Foundation

public struct StoresDTOMapper {
    
    static func map(_ dto: StoresDTO) -> [Store] {
        dto.stores.map {
            StoreDTOMapper.map($0)
        }
    }
}

struct StoreDTOMapper {
    
    static func map(_ dto: StoreDTO) -> Store {
        Store(code: dto.code, name: dto.name)
    }
}
