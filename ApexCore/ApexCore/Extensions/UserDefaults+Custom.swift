//
//  UserDefaults+Custom.swift
//  ApexCore
//
//  Created by Olivier Rigault on 01/12/2021.
//
//  Reference:
//  - https://medium.com/@umairhassanbaig/ios-swift-how-to-save-custom-objects-to-userdefaults-using-propertylistencoder-decoder-with-e48583f0ec3a

import Foundation

public extension UserDefaults {
    
    /**
     Store encodable object as a json string in User Defaults.
     
     - parameters:
        - object: encodable object.
        - key: User Defaults key.

     This function store an encodable object as a json string in User Defaults. It is used to store the last store selected by the user.
     */
    
    func setCustomObject<T: Encodable>(_ object: T?, forKey key: String) {
        guard let object = object else {
            removeObject(forKey: key)
            return
        }
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        guard let jsonData = try? encoder.encode(object) else { return }
        let jsonString = String(bytes: jsonData, encoding: .utf8)
        UserDefaults.standard.set(jsonString, forKey: key)
    }

    /**
     Returns decodable object stored as a json string in User Defaults.
     
     - returns:
     A decodable object, stored as a json string in User Defaults, or nil if not present.
     
     - parameters:
        - key: User Defaults key.
     
     This function decodable object stored as a json string in User Defaults. It is used to get the last store selected by the user.
     */
    
    func customObject<T: Decodable>(forKey key: String) -> T? {
        guard let jsonString = UserDefaults.standard.string(forKey: key) else {
            return nil
        }
        guard let jsonData = jsonString.data(using: .utf8) else {
            return nil
        }
        guard let value = try? JSONDecoder().decode(T.self, from: jsonData) else {
            return nil
        }
        return value
    }
}
