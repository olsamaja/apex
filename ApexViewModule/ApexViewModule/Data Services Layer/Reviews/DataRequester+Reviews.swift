//
//  DataRequester+Reviews.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 09/07/2021.
//
//  Use iTunes Search API rss service
//  - https://itunes.apple.com//gb/rss/customerreviews/id=\<appId>/mostrecent/json
//
//  Source:
//  - https://developer.apple.com/documentation/appstoreconnectapi/app_store/customer_reviews/

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
    let page: Int
    
    init(appId: Int, storeCode: String, page: Int = 1) {
        self.appId = appId
        self.storeCode = storeCode
        self.page = page
    }
    
    func path() -> String {
        return "/\(storeCode)/rss/customerreviews/id=\(appId)/page=\(page)/mostrecent/json"
    }
}
