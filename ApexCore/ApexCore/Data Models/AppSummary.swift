//
//  AppSummary.swift
//  ApexCore
//
//  Created by Olivier Rigault on 07/12/2021.
//

import Foundation

public struct AppSummary {
    
    public let trackId: Int
    public let trackName: String
    public let sellerName: String
    public let storeCode: String
    
}

extension AppSummary: Hashable {}
