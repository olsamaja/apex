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
    
    static var defaultStore: AppStore? {
        get {
            guard let dto = AppStoreLocalRepository.defaultStore else { return nil }
            return AppStoreDTOMapper.map(dto)
        }
        set(newStore) {
            guard let store = newStore else { return }
            AppStoreLocalRepository.defaultStore = AppStoreDTOMapper.map(store)
        }
    }
}
