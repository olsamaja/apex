//
//  DataRequester+Reviews.swift
//  ApexReviewsModule
//
//  Created by Olivier Rigault on 09/07/2021.
//

import Combine
import ApexConfiguration
import ApexNetwork
import ApexCore

extension DataRequester {
    
    public func getReviews(with appId: String) -> AnyPublisher<ReviewsDTO, DataError> {
        loadData(with: ReviewsApi(appId: appId).urlComponents())
    }
}

struct ReviewsApi: ApiProtocol {
    
    let appId: String
    
    func path() -> String {
        return "/gb/rss/customerreviews/id=\(appId)/mostrecent/json"
    }
}

extension DataManager {
    
    func getReviews(appId: String) -> AnyPublisher<[Review], DataError> {
        return dataRequester.getReviews(with: appId)
            .mapError { $0 }
            .map {
                ReviewsDTOMapper.map($0)
            }
            .eraseToAnyPublisher()
    }
}
