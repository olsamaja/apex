//
//  DataRequester+Reviews.swift
//  ApexReviewsModule
//
//  Created by Olivier Rigault on 09/07/2021.
//

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
