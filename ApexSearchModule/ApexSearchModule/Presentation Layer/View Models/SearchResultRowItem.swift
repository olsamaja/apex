//
//  SearchResultRowItem.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 11/07/2021.
//

import Foundation
import ApexCore

public struct SearchResultRowItem: Identifiable {
    
    public let id: String
    let appDetails: AppDetails

    init(appDetails: AppDetails) {
        self.id = UUID().uuidString
        self.appDetails = appDetails
    }
}

extension SearchResultRowItem: Equatable {}
