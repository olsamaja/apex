//
//  StoredAppsTests.swift
//  ApexCoreTests
//
//  Created by Olivier Rigault on 08/05/2024.
//

import XCTest
import Testing
@testable import ApexCore

final class StoredAppsTests: XCTestCase {
    
    private var userDefaults: UserDefaults!
    
    enum Constants {
        static let apps = [
            AppSummary(trackId: 123, trackName: "track123", sellerName: "seller1", storeCode: "code1"),
            AppSummary(trackId: 456, trackName: "track456", sellerName: "seller2", storeCode: "code2", isFavorite: true),
            AppSummary(trackId: 789, trackName: "track789", sellerName: "seller3", storeCode: "code3")]
    }

    override func setUpWithError() throws {
        userDefaults = UserDefaults(suiteName: #file)
    }
    
    override func tearDownWithError() throws {
        userDefaults.removePersistentDomain(forName: #file)
        userDefaults.synchronize()
    }

    func testAddAndRemoveApps() throws {
        let apps = StoredApps(defaults: userDefaults)
        for app in Constants.apps {
            apps.add(app)
        }
        #expect(apps.apps.count == 3)
        #expect(apps.contains(Constants.apps[1]))

        apps.remove(Constants.apps[1])
        #expect(apps.apps.count == 2)
        #expect(!apps.contains(Constants.apps[1]))
    }

    func testFavoriteApps() throws {
        let apps = StoredApps(defaults: userDefaults)
        for app in Constants.apps {
            apps.add(app)
        }
        #expect(apps.favorites.count == 1)
        #expect(apps.favorites.contains(Constants.apps[1]))
    }

    func testToggleFavoriteApps() throws {
        let apps = StoredApps(defaults: userDefaults)
        for app in Constants.apps {
            apps.add(app)
        }
        #expect(apps.favorites.count == 1)
        #expect(apps.favorites.contains(Constants.apps[1]))
        
        // Remove 2nd app from favorites
        apps.toggleFavorite(Constants.apps[1])
        #expect(apps.favorites.count == 0)

        // Add 1st app to favorites
        apps.toggleFavorite(Constants.apps[0])
        #expect(apps.favorites.count == 1)
        
        let expectedFavorite = AppSummary(trackId: 123, trackName: "track123", sellerName: "seller1", storeCode: "code1", isFavorite: true)

        #expect(apps.favorites.contains(expectedFavorite))
        
        apps.deleteAll()
    }
}

extension StoredApps {

    // returns true if our set contains this app
    func contains(_ app: AppSummary) -> Bool {
        apps.contains(app)
    }

    func deleteAll() {
        apps.removeAll()
        save()
    }
}
