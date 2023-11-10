//
//  Store.swift
//  ApexStoreModule
//
//  Created by Olivier Rigault on 17/11/2021.
//

import Foundation

public struct Store {
    
    public let code: String
    public let name: String
    
    public init(code: String, name: String) {
        self.code = code
        self.name = name
    }
}

extension Store: Equatable {}
