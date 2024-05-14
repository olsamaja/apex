//
//  DataError.swift
//  ApexCore
//
//  Created by Olivier Rigault on 09/07/2021.
//
//  Source:
//  - https://www.tutorialspoint.com/how-to-provide-a-localized-description-with-an-error-type-in-swift

import Foundation

public enum DataError: Error {
    case invalidRequest
    case invalidResponse
    case parsing(description: String)
    case network(description: String)
}

extension DataError: Equatable {}

extension DataError: CustomStringConvertible {
    
    public var description: String {
      switch self {
         case .invalidRequest:
            return "There is a problem with the request."
          
       case .invalidResponse:
          return "The server responds with an unexpected format or status code."

         case .parsing(let message):
            return "The data cannot be parsed: \(message)."
            
         case .network(let message):
            return "There is an unexpected error with the network: \(message)."
      }
   }
}
