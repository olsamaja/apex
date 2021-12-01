//
//  AppStoreDTO.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 25/11/2021.
//

import Foundation

struct AppStoreDTO: Codable {
    let code: String
    let name: String
}

extension AppStoreDTO: Equatable {}
