//
//  Date+StringTests.swift
//  ApexCoreTests
//
//  Created by Olivier Rigault on 08/05/2024.
//

import Testing
@testable import ApexCore

struct Date_StringTests {
    
    let date = {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(abbreviation: "GMT")!
        return calendar.startOfDay(for: Date(timeIntervalSince1970: 1590242591))
    }()
    
    @Test func defaultFormat() async throws {
        #expect(date.toString() == "23/05/2020")
    }
    
    @Test func customFormat() async throws {
        #expect(date.toString(format: "yyyy-MM-dd") == "2020-05-23")
    }
}
