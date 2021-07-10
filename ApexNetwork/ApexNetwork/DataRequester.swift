//
//  DataRequester.swift
//  ApexNetwork
//
//  Created by Olivier Rigault on 09/07/2021.
//

import Foundation
import Combine
import Resolver
import ApexConfiguration
import ApexCore

public final class DataRequester {
    
    @OptionalInjected var session: URLSession?
    @OptionalInjected var configuration: Configuration?
    
    public static var shared = DataRequester()
    
    public init() {}
    
    /**
     Fetch decodable data from the server.
     
     - returns:
     A publisher of decoable data or an error.
     
     - parameters:
        - components: URL compoments used in the request.
     
     This function returns data from the LastFM server.
     */
    
    public func loadData<T>(with components: URLComponents) -> AnyPublisher<T, DataError> where T: Decodable {
        
        guard let url = components.url else {
            let error = DataError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        guard let urlSession = session else {
            let error = DataError.network(description: "Couldn't find a url session")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return urlSession.execute(URLRequest(url: url))
    }
}
