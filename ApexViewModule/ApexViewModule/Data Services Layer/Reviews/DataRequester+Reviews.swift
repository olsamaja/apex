//
//  DataRequester+Reviews.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 09/07/2021.
//
//  Use iTunes Search API rss service
//  - https://itunes.apple.com//gb/rss/customerreviews/id=\<appId>/mostrecent/json

import Combine
import ApexNetwork
import ApexCore

extension DataRequester {
    
    public func getReviews(with appId: Int, storeCode: String) -> AnyPublisher<ReviewsDTO, DataError> {
        loadData(with: ReviewsApi(appId: appId, storeCode: storeCode.lowercased()).urlComponents())
    }
}

struct ReviewsApi: ApiProtocol {
    
    let appId: Int
    let storeCode: String
    
    func path() -> String {
        return "/\(storeCode)/rss/customerreviews/id=\(appId)/mostrecent/json"
    }
}
