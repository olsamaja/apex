//
//  DataManager+Reviews.swift
//  ApexReviewsModule
//
//  Created by Olivier Rigault on 14/07/2021.
//

import Combine
import ApexNetwork
import ApexCore

extension DataManager {
    
    func getReviews(appId: Int) -> AnyPublisher<[Review], DataError> {
        return dataRequester.getReviews(with: appId)
            .mapError { $0 }
            .map {
                ReviewsDTOMapper.map($0)
            }
            .eraseToAnyPublisher()
    }
}
