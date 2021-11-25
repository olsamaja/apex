//
//  AppStoreManager.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 25/11/2021.
//

import Foundation


public struct AppStoreManager {
    
    static var allStores: [AppStore] {
        get { AppStoreLocalRepository.allStores.map { AppStoreDTOMapper.map($0) } }
    }
}
