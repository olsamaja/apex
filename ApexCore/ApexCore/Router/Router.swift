//
//  Router.swift
//  ApexCore
//
//  Created by Rigault, Olivier on 19/01/2023.
//

import Combine

public final class Router: ObservableObject {
    
    @Published public var path: [Route] = []
    
    public init() {}
}
