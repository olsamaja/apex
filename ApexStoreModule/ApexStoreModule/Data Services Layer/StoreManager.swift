//
//  StoreManager.swift
//  ApexStoreModule
//
//  Created by Olivier Rigault on 19/11/2021.
//

import Foundation

struct StoreManager {
    
    func getAllStores() -> [Store] {
        StoreLocalRepository.allStores()
    }

    static var currentStore: Store {
        get { StoreLocalRepository.currentStore }
    }
    
    static func setCurrentStore(with code: String) {
        StoreLocalRepository.setCurrentStore(with: code)
    }
}
