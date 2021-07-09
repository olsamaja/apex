//
//  ConfigurationDTO.swift
//  ApexConfiguration
//
//  Created by Olivier Rigault on 09/07/2021.
//

import Foundation
import ApexCore

public struct ConfigurationDTO {

    let scheme: String?
    let host: String?

    init(with bundle: Bundle) {
        scheme = bundle.infoForKey("APEX_API_SCHEME")
        host = bundle.infoForKey("APEX_API_HOST")
    }
    
    init(scheme: String?, host: String?) {
        self.scheme = scheme
        self.host = host
    }
}
