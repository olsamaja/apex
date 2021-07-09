//
//  ConfigurationDTOMapper.swift
//  ApexConfiguration
//
//  Created by Olivier Rigault on 09/07/2021.
//

import Foundation
import ApexCore

public struct ConfigurationDTOMapper {
    
    enum ValidationError: Error {
        case empty(_ property: Property)
        case invalid(_ property: Property)

        enum Property: String {
            case scheme
            case host
        }
    }

    static func map(_ dto: ConfigurationDTO) throws -> Configuration {
        
        guard let schemeString = dto.scheme else { throw ValidationError.empty(.scheme) }
        guard let scheme = Configuration.Scheme(string: schemeString) else { throw ValidationError.invalid(.scheme) }
        guard let host = dto.host else { throw ValidationError.empty(.host) }

        return Configuration(scheme: scheme, host: host)
    }
}
