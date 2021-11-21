//
//  SelectedStore.swift
//  ApexStoreModule
//
//  Created by Olivier Rigault on 19/11/2021.
//

import Foundation

public class SelectedStore: ObservableObject {
    
    private var currentStore: Store
    
    public init() {
        self.currentStore = StoreManager.currentStore
    }
    
    var current: Store {
        get { currentStore }
        set (newValue) {
            objectWillChange.send()
            currentStore = newValue
            StoreManager.setCurrentStore(newValue)
        }
    }
}
