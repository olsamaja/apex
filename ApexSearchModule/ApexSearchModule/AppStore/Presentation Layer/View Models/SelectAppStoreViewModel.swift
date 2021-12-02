//
//  SelectAppStoreViewModel.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 25/11/2021.
//

import Foundation

public final class SelectAppStoreViewModel: ObservableObject {
    
    let stores = AppStoreManager.allStores
    @Published var selectedStore: AppStore? = AppStoreManager.defaultStore

    public init() {}
    
}
