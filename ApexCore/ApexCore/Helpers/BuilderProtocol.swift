//
//  BuilderProtocol.swift
//  ApexCore
//
//  Created by Olivier Rigault on 09/07/2021.
//

import Foundation

public protocol BuilderProtocol {
    
    associatedtype T
    
    func build() -> T
}
