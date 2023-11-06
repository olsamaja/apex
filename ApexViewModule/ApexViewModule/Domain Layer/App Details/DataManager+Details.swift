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
    
    func getAppDetails(appId: Int, storeCode: String) -> AnyPublisher<AppDetails, DataError> {
        return dataRequester.getAppDetails(with: appId, storeCode: storeCode)
            .mapError {
                print("error: " + $0.localizedDescription)
                return $0
            }
            .map {
                AppDetailsDTOMapper.map($0)
            }
            .eraseToAnyPublisher()
    }
}
