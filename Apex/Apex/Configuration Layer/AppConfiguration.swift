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
import ApexSearchModule
import ApexSettingsModule

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        registerConfigurationServices(with: Bundle.main)
        registerHomeService()
        registerNetworkServices()
        registerSearchService()
        registerSettingsService()
    }
}

private extension Resolver {
    
    static func registerHomeService() {
        register { AppsViewModel() as AppsViewModel }
    }
}
