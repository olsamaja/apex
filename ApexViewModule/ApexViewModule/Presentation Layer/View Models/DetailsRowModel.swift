//
//  AppDetailsRowViewModel.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 04/11/2023.
//

import Foundation

public struct DetailsRowModel: Identifiable {
    
    public let id: String
    let details: Details
    
    init(details: Details) {
        self.id = UUID().uuidString
        self.details = details
    }
}

extension DetailsRowModel {
    
    var rating: String { String(format: "Rating: %.1f", details.averageUserRating) }
    var trackName: String { details.trackName }
    var version: String { "Current version: v" + details.version }
    
}

extension DetailsRowModel: Equatable {
    public static func == (lhs: DetailsRowModel, rhs: DetailsRowModel) -> Bool {
        lhs.details == rhs.details
    }
}
