//
//  ApexApi.swift
//  ApexNetwork
//
//  Created by Olivier Rigault on 09/07/2021.
//

import Foundation

public enum ApexApi {
    
    case search(String)
    case reviews(String)
    
    var path: String {
        switch self {
        case .search:
            return "/search"
        case .reviews(let appId):
            return "/gb/rss/customerreviews/id=\(appId)/mostrecent/json"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .search(let term):
            return [
                URLQueryItem(name: "term", value: term),
                URLQueryItem(name: "country", value: "gb"),
                URLQueryItem(name: "media", value: "software")
            ]
        case .reviews:
            return []
        }
    }
}

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

struct SearchApi: ApiProtocol {
    
    let term: String
    
    func path() -> String {
        "/search"
    }

    func queryItems() -> [URLQueryItem] {
        [
            URLQueryItem(name: "term", value: term),
            URLQueryItem(name: "country", value: "gb"),
            URLQueryItem(name: "media", value: "software")
        ]
    }
}

public struct DataManager {
    
    public var dataRequester: DataRequester

    public init() {
        self.dataRequester = DataRequester()
    }
}
