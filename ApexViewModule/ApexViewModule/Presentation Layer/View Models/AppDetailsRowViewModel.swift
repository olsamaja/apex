//
//  AppDetailsRowViewModel.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 04/11/2023.
//

import Foundation

public struct AppDetailsRowViewModel: Identifiable {
    
    public let id: String
    let trackName: String
    let rating: String
    let version: String
    
    init(appDetails: AppDetails) {
        self.id = UUID().uuidString
        self.trackName = appDetails.trackName
        self.rating = String(format: "Rating: %.1f", appDetails.averageUserRating)
        self.version = "Current version: v" + appDetails.version
    }
}

extension AppDetailsRowViewModel: Equatable {}
