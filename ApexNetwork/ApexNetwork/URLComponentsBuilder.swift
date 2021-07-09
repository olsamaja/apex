//
//  URLComponentsBuilder.swift
//  ApexNetwork
//
//  Created by Olivier Rigault on 09/07/2021.
//

import Foundation
import Resolver
import ApexConfiguration
import ApexCore

public final class URLComponentsBuilder: BuilderProtocol {
    
    @OptionalInjected var configuration: Configuration?
    
    var api: ApexApi?
    var queryItems = [URLQueryItem]()
    
    public init() {}
    
    public func with(_ api: ApexApi) -> URLComponentsBuilder {
        self.api = api
        return self
    }

    public func build() -> URLComponents {
        
        var components = URLComponents()
        
        guard let configuration = configuration, let api = api else {
            return components
        }
        
        components.scheme = configuration.scheme.rawValue
        components.host = configuration.host
        components.path = api.path
        components.queryItems = api.queryItems

        return components
    }
}
