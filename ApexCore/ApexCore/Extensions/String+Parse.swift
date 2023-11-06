//
//  String+Parse.swift
//  ApexCore
//
//  Created by Olivier Rigault on 17/09/2021.
//

import Foundation
import Combine

public extension String {
    
    enum DecodingStrategy {
        case none
        case deletingNewlineCharacters
    }
    
    func parse<T>(with decodingStrategy: DecodingStrategy = .deletingNewlineCharacters) -> AnyPublisher<T, DataError> where T: Decodable {
        switch decodingStrategy {
        case .none:
            return Data(self.utf8).decode()
        case .deletingNewlineCharacters:
            return Data(self.replacingOccurrences(of: "\n", with: "").utf8).decode()
        }
    }
}
