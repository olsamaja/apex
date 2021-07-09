//
//  OLLogger.swift
//  ApexCore
//
//  Created by Olivier Rigault on 09/07/2021.
//

import Foundation
import Logging

public struct OLLogger {
    
    private static var shared = OLLogger()
    
    private func logger(with bundleIdentifier: String?) -> Logger {
        Logger(label: bundleIdentifier ?? "Unknown application")
    }
    
    public static func info(_ message: Logger.Message,
                            with bundleIdentifier: String? = Bundle.main.bundleIdentifier) {
        OLLogger.shared.logger(with: bundleIdentifier).info(message)
    }
}
