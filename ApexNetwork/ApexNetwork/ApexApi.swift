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
                URLQueryItem(name: "media", value: "software"),
            ]
        case .reviews:
            return []
        }
    }
}
