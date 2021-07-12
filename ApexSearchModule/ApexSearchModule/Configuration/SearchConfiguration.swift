//
//  SearchConfiguration.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 09/07/2021.
//

import Foundation
import Resolver
import ApexCore

public extension Resolver {
    
    static func registerSearchService() {
        register { SearchViewModel(term: "") as SearchViewModel }
    }
}
