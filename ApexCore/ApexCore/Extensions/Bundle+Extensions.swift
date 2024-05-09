//
//  Bundle+Extensions.swift
//  ApexCore
//
//  Created by Olivier Rigault on 09/07/2021.
//

import Foundation

public extension Bundle {
    
    // TODO: add throws error
    func loadContents(of file: String, ofType type: String) -> String? {
        
        var contents: String?
        
        if let filepath = self.path(forResource: file, ofType: type) {
            do {
                contents = try String(contentsOfFile: filepath)
            } catch let error {
                OLLogger.info("\(file).\(type) contents could not be loaded.\nError: \(error)")
            }
        } else {
            OLLogger.info("\(file).\(type) not found")
        }
        
        return contents
    }

    func infoForKey(_ key: String) -> String? {
        return (self.infoDictionary?[key] as? String)?
            .replacingOccurrences(of: "\\", with: "")
     }
}
