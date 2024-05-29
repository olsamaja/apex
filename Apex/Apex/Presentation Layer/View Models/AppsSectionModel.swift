//
//  AppsSectionModel.swift
//  Apex
//
//  Created by Olivier Rigault on 10/11/2023.
//

import Foundation
import ApexCore
import ApexStoreModule

public struct AppsSectionModel: Identifiable {
    
    public var id = UUID().uuidString
    
    let store: Store
    public let apps: [AppRowModel]
    public let showAddAppButton: Bool
    
    public init(store: Store, apps: [AppRowModel], showAddAppButton: Bool) {
        self.store = store
        self.apps = apps
        self.showAddAppButton = showAddAppButton
    }
    
    public func search(with term: String) -> AppsSectionModel? {
        
        guard !term.isEmpty else { return self }

        let filteredApps = apps.filter { $0.trackName.lowercased().contains(term.lowercased()) }
        
        guard filteredApps.count > 0 else { return nil }

        return AppsSectionModel(store: store, apps: filteredApps, showAddAppButton: showAddAppButton)
    }
}

extension AppsSectionModel {
    
    static func sort(from items: [AppRowModel], showAddAppButton: Bool = false) -> [AppsSectionModel] {
        searchAndSort(from: items, with: "", showAddAppButton: showAddAppButton)
    }

    static func searchAndSort(from items: [AppRowModel], with term: String, showAddAppButton: Bool) -> [AppsSectionModel] {
        
        let sections = AppsSectionModel.makeSortedAppsSectionRowsModel(with: items, showAddAppButton: showAddAppButton)
        
        if term.isEmpty {
            return sections
        }
        
        let filteredSections = sections.compactMap { section in
            section.search(with: term)
        }
        
        return filteredSections
    }

    static func makeSortedAppsSectionRowsModel(with unsortedRows: [AppRowModel], showAddAppButton: Bool) -> [AppsSectionModel] {
        
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
            return AppsSectionModel(store: store, apps: sortedApps, showAddAppButton: showAddAppButton)
        }
        
        return sections
    }
}

extension AppsSectionModel: Equatable {
    public static func == (lhs: AppsSectionModel, rhs: AppsSectionModel) -> Bool {
        (lhs.store == rhs.store) && (lhs.apps == rhs.apps)
    }
}
