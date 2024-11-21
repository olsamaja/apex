//
//  String+ExtensionsTests.swift
//  ApexCoreTests
//
//  Created by Olivier Rigault on 05/06/2024.
//

import Testing
@testable import ApexCore

@Test func convertStringToInt() {
    #expect("426137600".toInt == 426137600)
    #expect("not an integer".toInt == 0)
}
