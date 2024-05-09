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
        static let gmtCalendar: Calendar = {
            var calendar = Calendar(identifier: .gregorian)
            calendar.timeZone = TimeZone(abbreviation: "GMT")!
            return calendar
        }()
        static let date = Constants.gmtCalendar.startOfDay(for: Date(timeIntervalSince1970: 1590242591))
    }
    
    func testDefaultDateFormatIsValid() throws {
        XCTAssertEqual(Constants.date.toString(), "23/05/2020")
    }

    func testAnotherDateFormatIsValid() throws {
        XCTAssertEqual(Constants.date.toString(format: "yyyy-MM-dd"), "2020-05-23")
    }
}
