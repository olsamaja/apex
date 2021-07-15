//
//  DataManager.swift
//  ApexNetwork
//
//  Created by Olivier Rigault on 14/07/2021.
//

import Foundation

public struct DataManager {
    
    public var dataRequester: DataRequester

    public init() {
        self.dataRequester = DataRequester.shared
    }
}
