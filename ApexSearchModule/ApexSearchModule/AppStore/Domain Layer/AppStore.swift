//
//  AppStore.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 25/11/2021.
//

import Foundation

public struct AppStore {
    let code: String
    let name: String
}

extension AppStore: Hashable {}

public struct AppStoreSection {
    let title: String
    let stores: [AppStore]
}

extension AppStoreSection: Hashable {}
