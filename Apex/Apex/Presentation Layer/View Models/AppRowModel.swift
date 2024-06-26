//
//  AppRowItem.swift
//  Apex
//
//  Created by Olivier Rigault on 10/12/2021.
//

import Foundation
import ApexCore

public struct AppRowModel: Identifiable, Hashable {
    
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

extension AppRowModel: Equatable {
    public static func == (lhs: AppRowModel, rhs: AppRowModel) -> Bool {
        lhs.appSummary == rhs.appSummary
    }
}
