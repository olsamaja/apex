//
//  DataRequester+Search.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 11/07/2021.
//

import Combine
import ApexConfiguration
import ApexNetwork
import ApexCore

extension DataRequester {
    
    public func search(with term: String) -> AnyPublisher<SearchResultsDTO, DataError> {
        loadData(with: SearchApi(term: term).urlComponents())
    }
}

struct SearchApi: ApiProtocol {
    
    let term: String
    
    func path() -> String {
        return "/gb/rss/customerreviews/id=\(term)/mostrecent/json"
    }
}

extension DataManager {
    
    func search(with term: String) -> AnyPublisher<[SearchResult], DataError> {
        return dataRequester.search(with: term)
            .mapError { $0 }
            .map {
                SearchResultsDTOMapper.map($0)
            }
            .eraseToAnyPublisher()
    }
}
