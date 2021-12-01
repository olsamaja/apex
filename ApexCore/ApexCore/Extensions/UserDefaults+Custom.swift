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
