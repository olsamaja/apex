//
//  ConfigurationServices.swift
//  ApexConfiguration
//
//  Created by Olivier Rigault on 09/07/2021.
//

import Foundation
import Resolver
import ApexCore

public extension Resolver {
    
    static func registerConfigurationServices(with bundle: Bundle) {
        do {
            let configuration = try ConfigurationDataManager.load(with: bundle)
            register { configuration as Configuration }
        } catch {
            OLLogger.info("\(error) - Unable to load configuration")
        }
    }
}
