//
//  StoreRowItem.swift
//  ApexStoreModule
//
//  Created by Olivier Rigault on 17/11/2021.
//

import Foundation

public struct StoreRowItem: Identifiable {
    
    public let id: String
    let store: Store

    init(store: Store) {
        self.id = UUID().uuidString
        self.store = store
    }

    static func allStores() -> [StoreRowItem] {
        StoreManager.allStores.map { StoreRowItem(store: $0) }
    }
}
