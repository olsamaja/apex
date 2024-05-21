//
//  StoredAppsTests.swift
//  ApexCoreTests
//
//  Created by Olivier Rigault on 08/05/2024.
//

import XCTest
@testable import ApexCore

final class StoredAppsTests: XCTestCase {
    
    private var userDefaults: UserDefaults!
    
    enum Constants {
        static let apps = [
            AppSummary(trackId: 123, trackName: "track123", sellerName: "seller1", storeCode: "code1"),
            AppSummary(trackId: 456, trackName: "track456", sellerName: "seller2", storeCode: "code2"),
            AppSummary(trackId: 789, trackName: "track789", sellerName: "seller3", storeCode: "code3")]
    }

    override func setUpWithError() throws {
        userDefaults = UserDefaults(suiteName: #file)
    }
    
    override func tearDownWithError() throws {
        userDefaults.removePersistentDomain(forName: #file)
    }

    func testAddAndRemoveApps() throws {
        let apps = StoredApps(defaults: userDefaults)
        for app in Constants.apps {
            apps.add(app)
        }
        XCTAssertEqual(apps.apps.count, 3)
        XCTAssertTrue(apps.contains(Constants.apps[1]))

        apps.remove(Constants.apps[1])
        XCTAssertEqual(apps.apps.count, 2)
        XCTAssertFalse(apps.contains(Constants.apps[1]))
    }
}
