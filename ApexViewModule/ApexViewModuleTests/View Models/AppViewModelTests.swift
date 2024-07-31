//
//  AppViewModelTests.swift
//  ApexViewModuleTests
//
//  Created by Olivier Rigault on 30/07/2024.
//

import XCTest
@testable import ApexCore
@testable import ApexViewModule

final class AppViewModelTests: XCTestCase {

    enum Constants {
        static let appSummary = AppSummary(trackId: 1234, trackName: "My App", sellerName: "Seller", storeCode: "Store")
    }
    
    func testExample() throws {
        let model = AppViewModel(appSummary: Constants.appSummary)
    }

}
