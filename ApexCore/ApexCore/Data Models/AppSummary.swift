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
    public let isFavorite: Bool
    
    public init(trackId: Int, trackName: String, sellerName: String, storeCode: String, isFavorite: Bool = false) {
        self.trackId = trackId
        self.trackName = trackName
        self.sellerName = sellerName
        self.storeCode = storeCode
        self.isFavorite = isFavorite
    }
}

extension AppSummary: Hashable {}
extension AppSummary: Equatable {}
