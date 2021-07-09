//
//  MockURLSession.swift
//  ApexNetwork
//
//  Created by Olivier Rigault on 09/07/2021.
//

import Foundation

extension URLSession {
    
    static func makeMockURLSession(_ protocolClasses: [AnyClass]? = [MockURLProtocol.self]) -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = protocolClasses
        return URLSession(configuration: configuration)
    }
    
}
