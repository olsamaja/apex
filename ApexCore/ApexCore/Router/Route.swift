//
//  Route.swift
//  ApexCore
//
//  Created by Rigault, Olivier on 19/01/2023.
//

import Combine

public enum Route: Hashable {
    case appDetails(Int, String, String, String)
    case selectStore(String)
}
