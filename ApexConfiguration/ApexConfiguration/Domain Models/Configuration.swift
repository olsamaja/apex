//
//  Configuration.swift
//  ApexConfiguration
//
//  Created by Olivier Rigault on 09/07/2021.
//

import Foundation
import ApexCore

public struct Configuration {
    
    public enum Scheme: String {
        case http
        case https
    }
    
    public let scheme: Scheme
    public let host: String

}

extension Configuration.Scheme: CaseIterable {
    
    init?(string: String) {
        for value in Configuration.Scheme.allCases where "\(value)" == string {
            self = value
            return
        }
        
        return nil
    }
}
