//
//  AppsSectionRowsModel.swift
//  Apex
//
//  Created by Olivier Rigault on 10/11/2023.
//

import Foundation
import ApexCore
import ApexStoreModule

public struct AppsSectionRowsModel: Identifiable {
    
    public var id = UUID().uuidString
    
    let store: Store
    public let apps: [AppRowModel]
    
    public init(store: Store, apps: [AppRowModel]) {
        self.store = store
        self.apps = apps
    }
    
    public func search(with term: String) -> AppsSectionRowsModel? {
        
        guard !term.isEmpty else { return self }

        let filteredApps = apps.filter { $0.trackName.lowercased().contains(term.lowercased()) }
        
        guard filteredApps.count > 0 else { return nil }

        return AppsSectionRowsModel(store: store, apps: filteredApps)
    }
}

extension AppsSectionRowsModel {
    
    static func searchAndSort(from items: [AppRowModel], with term: String) -> [AppsSectionRowsModel] {
        
        let sections = AppsSectionRowsModel.makeSortedAppsSectionRowsModel(with: items)
        
        if term.isEmpty {
            return sections
        }
        
        let filteredSections = sections.compactMap { section in
            section.search(with: term)
        }
        
        return filteredSections
    }

    static func makeSortedAppsSectionRowsModel(with unsortedRows: [AppRowModel] ) -> [AppsSectionRowsModel] {
        
        // Build an array of Stores (sorted by name) from the unsorted array of AppRowModels
        let storeCodes = unsortedRows.map { $0.storeCode }
        let uniqueStores = storeCodes.compactMap { code in
            let store = StoreManager.allStores.first { code == $0.code }
            return store
        }.uniqued()
        
        let sortedStores = uniqueStores.sorted(by: { store1, store2 in
            store1.name < store2.name
        })
        
        // Build sections of AppRowModels (apps sorted aplhabetically)
        let sections = sortedStores.map { store in
            let apps = unsortedRows.filter { app in
                app.storeCode == store.code
            }
            let sortedApps = apps.sorted(by: { app1, app2 in
                app1.trackName.lowercased() < app2.trackName.lowercased()
            })
            return AppsSectionRowsModel(store: store, apps: sortedApps)
        }
        
        return sections
    }
}

extension AppsSectionRowsModel: Equatable {
    public static func == (lhs: AppsSectionRowsModel, rhs: AppsSectionRowsModel) -> Bool {
        (lhs.store == rhs.store) && (lhs.apps == rhs.apps)
    }
}
