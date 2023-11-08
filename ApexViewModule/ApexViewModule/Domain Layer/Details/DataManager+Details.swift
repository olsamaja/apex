//
//  DataManager+Details.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 02/11/2023.
//

import Combine
import ApexNetwork
import ApexCore

public extension DataManager {
    
    func getDetails(appId: Int, storeCode: String) -> AnyPublisher<Details, DataError> {
        return dataRequester.getDetails(with: appId, storeCode: storeCode)
            .mapError {
                print("error: " + $0.localizedDescription)
                return $0
            }
            .map {
                DetailsDTOMapper.map($0)
            }
            .eraseToAnyPublisher()
    }
}
