//
//  StoreRepository.swift
//  ApexStoreModule
//
//  Created by Olivier Rigault on 18/11/2021.
//

import Foundation

struct StoreLocalRepository {
    
    private enum Constants {
        static let defaultStore = Store(code: "UK", name: "United Kingdom")
        static let storeCodeDefaultsKey = "StoreCode"
    }
    
    static var allStores: [Store] {
        get {
            let stores = [
                Constants.defaultStore,
                Store(code: "CN", name: "China"),
                Store(code: "DK", name: "Denmark"),
                Store(code: "NL", name: "Netherlands"),
                Store(code: "AT", name: "Austria"),
                Store(code: "CA", name: "Canada"),
                Store(code: "US", name: "United States"),
                Store(code: "FI", name: "Finland"),
                Store(code: "DE", name: "Germany"),
                Store(code: "GR", name: "Greece"),
                Store(code: "ID", name: "Indonesia"),
                Store(code: "IT", name: "Italy"),
                Store(code: "JP", name: "Japan"),
                Store(code: "KR", name: "Korea"),
                Store(code: "MY", name: "Malaysia"),
                Store(code: "BR", name: "Brazil"),
                Store(code: "PT", name: "Portugal"),
                Store(code: "RU", name: "Russia"),
                Store(code: "MX", name: "Mexico"),
                Store(code: "ES", name: "Spain"),
                Store(code: "SE", name: "Sweden"),
                Store(code: "TH", name: "Thailand"),
                Store(code: "TR", name: "Turkey"),
                Store(code: "VN", name: "Vietnam"),
                Store(code: "FR", name: "France")
            ]
            
        return stores.sorted { $0.name < $1.name }
        }
    }
    
    static var currentStore: Store {
        get {
            return currentStore(with: currentCode)
        }
    }
    
    static func setCurrentStore(with code: String) {
        currentCode = code
    }

    private static func currentStore(with code: String?) -> Store {
        guard let code = code,
              let store = allStores.first(where: { $0.code == code }) else {
            return Constants.defaultStore
        }
        return store
    }
    
    private static var currentCode: String? {
        get {
            let defaults = UserDefaults.standard
            return defaults.string(forKey: Constants.storeCodeDefaultsKey)
        }
        set(newCode) {
            let defaults = UserDefaults.standard
            defaults.setValue(newCode, forKey: Constants.storeCodeDefaultsKey)
        }
    }
}
