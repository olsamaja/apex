//
//  Data+Decode.swift
//  ApexCore
//
//  Created by Olivier Rigault on 09/07/2021.
//

import Foundation
import Combine

public extension Data {
    
    func decode<T: Decodable>() -> AnyPublisher<T, DataError> {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970

//        self.debugPrintJSONString()
        
        return Just(self)
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                .parsing(description: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}
