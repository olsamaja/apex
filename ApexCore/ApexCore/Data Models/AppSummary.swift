//
//  AppSummary.swift
//  ApexCore
//
//  Created by Olivier Rigault on 07/12/2021.
//

import Foundation

public struct AppSummary: Codable {
    
    public let trackId: Int
    public let trackName: String
    public let sellerName: String
    public let storeCode: String
    
    public init(trackId: Int, trackName: String, sellerName: String, storeCode: String) {
        self.trackId = trackId
        self.trackName = trackName
        self.sellerName = sellerName
        self.storeCode = storeCode
    }
}

extension AppSummary: Hashable {}
