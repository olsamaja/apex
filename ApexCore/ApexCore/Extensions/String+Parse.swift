//
//  String+Parse.swift
//  ApexCore
//
//  Created by Olivier Rigault on 17/09/2021.
//

import Foundation
import Combine

public extension String {
    func parse<T>() -> AnyPublisher<T, DataError> where T: Decodable {
        return Data(self.utf8).decode()
    }
}
