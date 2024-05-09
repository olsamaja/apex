//
//  DetailsDTOMapperTests.swift
//  ApexViewModuleTests
//
//  Created by Olivier Rigault on 09/11/2023.
//

import XCTest
@testable import ApexCore
@testable import ApexViewModule

final class DetailsDTOMapperTests: XCTestCase {

    func testSuccessfulMapper() throws {
        
        let dto = DetailsDTO(trackId: 123, trackName: "name", averageUserRating: 4.678, version: "1.2.3")

        let details = DetailsDTOMapper.map(dto)
        XCTAssertEqual(details.trackId, 123)
        XCTAssertEqual(details.trackName, "name")
        XCTAssertEqual(details.averageUserRating, 4.678)
        XCTAssertEqual(details.version, "1.2.3")
    }
}
