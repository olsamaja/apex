//
//  AppRowItem.swift
//  Apex
//
//  Created by Olivier Rigault on 10/12/2021.
//

import Foundation
import ApexCore

public struct AppRowItem: Identifiable {
    
    public let id: String
    let appSummary: AppSummary
    
    public var trackName: String {
        appSummary.trackName
    }

    public var storeCode: String {
        appSummary.storeCode
    }

    init(appSummary: AppSummary) {
        self.id = UUID().uuidString
        self.appSummary = appSummary
    }
}

extension AppRowItem: Equatable {}
