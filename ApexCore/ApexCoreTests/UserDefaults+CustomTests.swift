//
//  UserDefaults+CustomTests.swift
//  ApexCoreTests
//
//  Created by Olivier Rigault on 01/12/2021.
//

import Testing
@testable import ApexCore

struct UserDefaults_CustomTests {

    @Test func storeValue() throws {
        let simple = CodableSimpleStruct(code: "key", name: "name")
        UserDefaults.standard.setCustomObject(simple, forKey: "MY_KEY")
        let storedValue: CodableSimpleStruct? = UserDefaults.standard.customObject(forKey: "MY_KEY")
        #expect(storedValue == simple)
    }

    
    @Test func storeNilValue() throws {
        let simple: CodableSimpleStruct? = nil
        UserDefaults.standard.setCustomObject(simple, forKey: "MY_KEY")
        let storedValue: CodableSimpleStruct? = UserDefaults.standard.customObject(forKey: "MY_KEY")
        #expect(storedValue == simple)
    }

}

struct CodableSimpleStruct: Codable, Equatable {
    let code: String
    let name: String
}
