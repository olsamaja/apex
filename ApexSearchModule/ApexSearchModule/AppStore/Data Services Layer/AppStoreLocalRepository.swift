//
//  AppStoreLocalRepository.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 25/11/2021.
//

import Foundation

struct AppStoreLocalRepository {
    
    private enum Constants {
        static let defaultStoreKey = "DefaultStore"
    }
    
    static var allStores: [AppStoreDTO] {
        get {
            let stores = [
                AppStoreDTO(code: "GB", name: "United Kingdom"),
                AppStoreDTO(code: "CN", name: "China"),
                AppStoreDTO(code: "DK", name: "Denmark"),
                AppStoreDTO(code: "NL", name: "Netherlands"),
                AppStoreDTO(code: "AT", name: "Austria"),
                AppStoreDTO(code: "CA", name: "Canada"),
                AppStoreDTO(code: "US", name: "United States"),
                AppStoreDTO(code: "FI", name: "Finland"),
                AppStoreDTO(code: "DE", name: "Germany"),
                AppStoreDTO(code: "GR", name: "Greece"),
                AppStoreDTO(code: "ID", name: "Indonesia"),
                AppStoreDTO(code: "IT", name: "Italy"),
                AppStoreDTO(code: "JP", name: "Japan"),
                AppStoreDTO(code: "KR", name: "Korea"),
                AppStoreDTO(code: "MY", name: "Malaysia"),
                AppStoreDTO(code: "BR", name: "Brazil"),
                AppStoreDTO(code: "PT", name: "Portugal"),
                AppStoreDTO(code: "RU", name: "Russia"),
                AppStoreDTO(code: "MX", name: "Mexico"),
                AppStoreDTO(code: "ES", name: "Spain"),
                AppStoreDTO(code: "SE", name: "Sweden"),
                AppStoreDTO(code: "TH", name: "Thailand"),
                AppStoreDTO(code: "TR", name: "Turkey"),
                AppStoreDTO(code: "VN", name: "Vietnam"),
                AppStoreDTO(code: "FR", name: "France")
            ]
            
        return stores.sorted { $0.name < $1.name }
        }
    }
    
    public static var defaultStore: AppStoreDTO? {
        get {
            let dto: AppStoreDTO? = UserDefaults.standard.customObject(forKey: Constants.defaultStoreKey)
            return dto
        }
        set(newStore) {
            UserDefaults.standard.setCustomObject(newStore, forKey: Constants.defaultStoreKey)
        }
    }
}
