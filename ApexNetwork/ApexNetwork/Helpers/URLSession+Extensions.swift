//
//  URLSession+Extensions.swift
//  ApexNetwork
//
//  Created by Olivier Rigault on 09/07/2021.
//

import Foundation
import Combine
import ApexCore

extension URLSession {
    
    func execute<T: Decodable>(_ request: URLRequest,
                               resultQueue: DispatchQueue = .main) -> AnyPublisher<T, DataError> {
        
        OLLogger.info("URLRequest: \(String(describing: request.url?.absoluteURL))")
        
        return self.dataTaskPublisher(for: request)
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap() { pair in
                pair.data.decode()
            }
            .receive(on: resultQueue)
            .eraseToAnyPublisher()
    }
}
