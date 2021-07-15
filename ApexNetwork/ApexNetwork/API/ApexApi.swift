//
//  ApexApi.swift
//  ApexNetwork
//
//  Created by Olivier Rigault on 09/07/2021.
//

import Foundation

public protocol ApiProtocol {
    func path() -> String
    func queryItems() -> [URLQueryItem]
    func urlComponents() -> URLComponents
}

public extension ApiProtocol {
    
    func queryItems() -> [URLQueryItem] { [] }
    
    func urlComponents() -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = path()
        components.queryItems = queryItems()
        return components
    }
}
