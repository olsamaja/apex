//
//  StoreHeaderRowItem.swift
//  Apex
//
//  Created by Olivier Rigault on 10/11/2023.
//

import Foundation
import ApexCore
import ApexStoreModule

public struct StoreHeaderRowModel: Identifiable {
    
    public let id: String
    let store: Store
    
    public var storeCode: String { store.code }
    public var storeName: String { store.name }

    init(store: Store) {
        self.id = UUID().uuidString
        self.store = store
    }
}

extension StoreHeaderRowModel: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension StoreHeaderRowModel: Equatable {}
