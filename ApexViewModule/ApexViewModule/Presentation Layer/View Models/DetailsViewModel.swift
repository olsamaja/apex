//
//  DetailsViewModel.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 03/06/2024.
//

import Foundation

public struct DetailsViewModel: Identifiable {
    
    public let id: String
    public let details: Details
    
    public init(details: Details) {
        self.id = UUID().uuidString
        self.details = details
    }
}
