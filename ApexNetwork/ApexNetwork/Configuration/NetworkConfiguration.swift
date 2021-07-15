//
//  NetworkConfiguration.swift
//  ApexNetwork
//
//  Created by Olivier Rigault on 10/07/2021.
//

import Foundation
import Resolver
import ApexCore

public extension Resolver {
    
    static func registerNetworkServices() {
        register { URLSession.shared as URLSession }
    }
}
