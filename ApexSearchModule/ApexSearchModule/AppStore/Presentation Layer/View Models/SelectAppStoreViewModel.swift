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
    
    private func SearchStoreSection(with searchStore: String) -> AppStoreSection {
        if searchStore.isEmpty {
            return AppStoreSection(title: "All Stores", stores: stores)
        } else {
            return AppStoreSection(title: "All Stores",
                                   stores: stores.filter { $0.name.contains(searchStore) })
        }
    }
    
    public func AppStoreSections(with searchStore: String) -> [AppStoreSection] {
        var sections = [AppStoreSection]()
        if let selectedStore = selectedStore {
            sections.append(AppStoreSection(title: "Last Selected Store", stores: [selectedStore]))
        }
        sections.append(SearchStoreSection(with: searchStore))
        return sections
    }
}
