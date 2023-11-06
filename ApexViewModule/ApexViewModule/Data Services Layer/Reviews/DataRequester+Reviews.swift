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
    
    public func getReviews(with appId: Int) -> AnyPublisher<ReviewsDTO, DataError> {
        loadData(with: ReviewsApi(appId: appId).urlComponents())
    }
}

struct ReviewsApi: ApiProtocol {
    
    let appId: Int
    
    func path() -> String {
        return "/gb/rss/customerreviews/id=\(appId)/mostrecent/json"
    }
}
