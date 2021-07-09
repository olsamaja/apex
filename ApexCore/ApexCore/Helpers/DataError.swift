//
//  DataError.swift
//  ApexCore
//
//  Created by Olivier Rigault on 09/07/2021.
//

import Foundation

public enum DataError: Error {
    case invalidRequest
    case invalidResponse
    case parsing(description: String)
    case network(description: String)
}

extension DataError: Equatable {}
