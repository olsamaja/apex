//
//  UserDefaults+CustomTests.swift
//  ApexCoreTests
//
//  Created by Olivier Rigault on 01/12/2021.
//

import XCTest
@testable import ApexCore

class UserDefaults_CustomTests: XCTestCase {

    func testStoreValue() throws {
        let simple = CodableSimpleStruct(code: "key", name: "name")
        UserDefaults.standard.setCustomObject(simple, forKey: "MY_KEY")
        let storedValue: CodableSimpleStruct? = UserDefaults.standard.customObject(forKey: "MY_KEY")
        XCTAssertEqual(storedValue, simple)
    }

    
    func testStoreNilValue() throws {
        let simple: CodableSimpleStruct? = nil
        UserDefaults.standard.setCustomObject(simple, forKey: "MY_KEY")
        let storedValue: CodableSimpleStruct? = UserDefaults.standard.customObject(forKey: "MY_KEY")
        XCTAssertNil(storedValue)
    }

}

struct CodableSimpleStruct: Codable, Equatable {
    let code: String
    let name: String
}
