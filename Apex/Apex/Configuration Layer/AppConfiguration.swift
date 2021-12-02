//
//  AppConfiguration.swift
//  Apex
//
//  Created by Olivier Rigault on 10/07/2021.
//

import Foundation
import Resolver
import ApexConfiguration
import ApexNetwork

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        registerConfigurationServices(with: Bundle.main)
        registerNetworkServices()
    }
}
