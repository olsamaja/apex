//
//  StoreDTO.swift
//  ApexStoreModule
//
//  Created by Olivier Rigault on 19/11/2021.
//

import Foundation

struct StoreDTO: Decodable {
    let code: String
    let name: String
}

extension StoreDTO: Equatable {}

struct StoresDTO: Decodable {
    let stores: [StoreDTO]
}
