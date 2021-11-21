//
//  StoreManager.swift
//  ApexStoreModule
//
//  Created by Olivier Rigault on 19/11/2021.
//

import Foundation

struct StoreManager {
    
    static var allStores: [Store] {
        get { StoreLocalRepository.allStores }
    }

    static var currentStore: Store {
        get { StoreLocalRepository.currentStore }
    }
    
    static func setCurrentStore(_ store: Store) {
        StoreLocalRepository.setCurrentStore(with: store.code)
    }
}
