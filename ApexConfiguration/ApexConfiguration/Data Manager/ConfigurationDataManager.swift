//
//  ConfigurationDataManager.swift
//  ApexConfiguration
//
//  Created by Olivier Rigault on 09/07/2021.
//

import Foundation

public struct ConfigurationDataManager {
    
    public static func load(with bundle: Bundle) throws -> Configuration {
        
        let dto = ConfigurationDTO(with: bundle)
        
        do {
            let configuration = try ConfigurationDTOMapper.map(dto)
            return configuration
        } catch {
            throw error
        }
    }
    
}
