//
//  AnalyticsEvent.swift
//  ApexAnalytics
//
//  Created by Olivier Rigault on 08/07/2024.
//

import Foundation

public struct AnalyticsEvent {
    var name: String
    var parameters: [String: String]
    
    init(name: String, parameters: [String: String] = [:]) {
        self.name = name
        self.parameters = parameters
    }
}
