//
//  Date+StringTests.swift
//  ApexCoreTests
//
//  Created by Olivier Rigault on 08/05/2024.
//

import XCTest
@testable import ApexCore

final class Date_StringTests: XCTestCase {

    enum Constants {
        static let calendar = Calendar(identifier: .gregorian).TimeZone(abbreviation: "GMT")
    }
    
    func testDefaultDateFormatIsValid() throws {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(abbreviation: "GMT")!
        let date = calendar.startOfDay(for: Date(timeIntervalSince1970: 1590242591))
        XCTAssertEqual(date.toString(), "23/05/2020")
    }

    func testAnotherDateFormatIsValid() throws {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(abbreviation: "GMT")!
        let date = calendar.startOfDay(for: Date(timeIntervalSince1970: 1590242591))
        XCTAssertEqual(date.toString(format: "yyyy-MM-dd"), "2020-05-23")
    }
}
