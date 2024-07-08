//
//  AnalyticsProvider.swift
//  ApexAnalytics
//
//  Created by Olivier Rigault on 08/07/2024.
//
//  Source:
//  - https://andreaslydemann.com/architecting-an-analytics-service-for-ios-apps/

import Foundation

public protocol AnalyticsProvider {
    func reportEvent(name: String, parameters: [String: String])
}
