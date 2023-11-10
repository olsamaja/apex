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
    
    init(store: Store, apps: [AppRowModel]) {
        self.store = store
        self.apps = apps
    }
}

extension AppsSectionRowsModel {
    
    static func makeSortedAppsSectionRowsModel(with unsortedRows: [AppRowModel] ) -> [AppsSectionRowsModel] {
        
        return [AppsSectionRowsModel(store: Store(code: "GB", name: "United Kingdom"),
                                     apps: unsortedRows)]
    }

}
