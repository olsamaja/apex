//
//  DataRequester+Details.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 01/11/2023.
//
//  Use iTunes Search API Lookup service
//  - https://itunes.apple.com/lookup?id=<trackId>

import Combine
import ApexNetwork
import ApexCore

extension DataRequester {
    
    public func getAppDetails(with appId: Int, storeCode: String) -> AnyPublisher<AppDetailsDTO, DataError> {
        loadData(with: LookupApi(appId: appId, storeCode: storeCode).urlComponents())
    }
}

struct LookupApi: ApiProtocol {
    
    let appId: Int
    let storeCode: String
    
    func path() -> String {
        return "/lookup"
    }
    
    // TODO: Add country code to request for apps only present in some countries
    func queryItems() -> [URLQueryItem] {
        [
            URLQueryItem(name: "id", value: "\(appId)"),
            URLQueryItem(name: "country", value: "\(storeCode)"),
        ]
    }
}
