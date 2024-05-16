//
//  SelectedStore.swift
//  ApexStoreModule
//
//  Created by Olivier Rigault on 19/11/2021.
//

import Foundation

public class SelectedStore: ObservableObject {
    
    public init() {}
    
    public var current: Store {
        get { StoreManager.currentStore }
        set (newValue) {
            objectWillChange.send()
            StoreManager.setCurrentStore(newValue)
        }
    }
}
