//
//  DataRequester+Search.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 11/07/2021.
//

import Combine
import ApexNetwork
import ApexCore

extension DataRequester {
    
    func search(with term: String, storeCode: String) -> AnyPublisher<SearchResultsDTO, DataError> {
        loadData(with: SearchApi(term: term, storeCode: storeCode).urlComponents())
    }
}

struct SearchApi: ApiProtocol {
    
    let term: String
    let storeCode: String
    
    func path() -> String {
        return "/search"
    }
    
    func queryItems() -> [URLQueryItem] {
        [
            URLQueryItem(name: "term", value: term),
            URLQueryItem(name: "country", value: storeCode),
            URLQueryItem(name: "media", value: "software")
        ]
    }
}
