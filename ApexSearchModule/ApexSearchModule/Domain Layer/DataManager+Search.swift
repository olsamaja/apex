//
//  DataManager+Search.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 14/07/2021.
//

import Combine
import ApexNetwork
import ApexCore
import ApexStoreModule

extension DataManager {
    
    func search(with term: String) -> AnyPublisher<[SearchResult], DataError> {
        return dataRequester.search(with: term, storeCode: StoreManager.currentStore.code)
            .mapError { $0 }
            .map {
                SearchResultsDTOMapper.map($0)
            }
            .eraseToAnyPublisher()
    }
}
