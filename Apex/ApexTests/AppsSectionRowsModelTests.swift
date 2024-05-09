//
//  AppsSectionRowsModelTests.swift
//  ApexTests
//
//  Created by Olivier Rigault on 10/11/2023.
//

import XCTest
@testable import ApexCore
@testable import ApexStoreModule
@testable import Apex

final class AppsSectionRowsModelTests: XCTestCase {
    
    enum Constants {
        static let stores = ["GB": Store(code: "GB", name: "United Kingdom"),
                             "FR": Store(code: "FR", name: "France"),
                             "DE": Store(code: "DE", name: "Germany")]
        
        static let ukApps = [AppSummary(trackId: 123, trackName: "Great App", sellerName: "Acme Ltd", storeCode: "GB"),
                             AppSummary(trackId: 234, trackName: "TokTok", sellerName: "Tok Ltd", storeCode: "GB"),
                             AppSummary(trackId: 456, trackName: "Bip Bip", sellerName: "Coyote Ltd", storeCode: "GB")]
        
        static let frApps = [AppSummary(trackId: 123, trackName: "Bip Bip", sellerName: "Coyote Ltd", storeCode: "FR"),
                             AppSummary(trackId: 234, trackName: "TokTok", sellerName: "Tok Ltd", storeCode: "FR")]
        
        static let deApps = [AppSummary(trackId: 123, trackName: "Great App", sellerName: "Acme Gmbh", storeCode: "DE"),
                             AppSummary(trackId: 234, trackName: "TokTok", sellerName: "Tok Gmbh", storeCode: "DE"),
                             AppSummary(trackId: 456, trackName: "Bip Bip", sellerName: "Coyote Gmbh", storeCode: "DE")]
        static let ukSection = AppsSectionRowsModel(store: Constants.stores["GB"]!,
                                                    apps: [AppRowModel(appSummary: Constants.ukApps[2]),
                                                           AppRowModel(appSummary: Constants.ukApps[0]),
                                                           AppRowModel(appSummary: Constants.ukApps[1])])
        static let frSection = AppsSectionRowsModel(store: Constants.stores["FR"]!,
                                                    apps: [AppRowModel(appSummary: Constants.frApps[0]),
                                                           AppRowModel(appSummary: Constants.frApps[1])])
        static let deSection = AppsSectionRowsModel(store: Constants.stores["DE"]!,
                                                    apps: [AppRowModel(appSummary: Constants.deApps[2]),
                                                           AppRowModel(appSummary: Constants.deApps[0]),
                                                           AppRowModel(appSummary: Constants.deApps[1])])
    }
    
    func testSortedAppsSectionRowsModel() throws {
        
        // Expected result
        
        let expected = [Constants.frSection, Constants.deSection, Constants.ukSection]
        
        // Input (unsorted AppRowModels)
        
        let unsortedApps = [Constants.ukApps[0], Constants.frApps[0], Constants.deApps[0],
                            Constants.ukApps[1], Constants.frApps[1], Constants.deApps[1],
                            Constants.ukApps[2], Constants.deApps[2],]
        
        let unsortedAppRowModels = unsortedApps.map { AppRowModel(appSummary: $0) }
        
        let sections = AppsSectionRowsModel.makeSortedAppsSectionRowsModel(with: unsortedAppRowModels)
        
        XCTAssertEqual(sections, expected)
    }
    
    func testSearchAppsInOneSection() throws {
        
        let filteredSection1 = Constants.frSection.search(with: "Bip")
        XCTAssertNotNil(filteredSection1)
        XCTAssertEqual(filteredSection1!.apps.count, 1)
        
        let filteredSection2 = Constants.deSection.search(with: "p")
        XCTAssertNotNil(filteredSection2)
        XCTAssertEqual(filteredSection2!.apps.count, 2)
        XCTAssertEqual(filteredSection2!.apps[0].trackName, "Bip Bip")
        XCTAssertEqual(filteredSection2!.apps[1].trackName, "Great App")
    }
        
    func testSearchAppsInSeveralSections() throws {
        
        // Input (unsorted AppRowModels)
        
        let unsortedApps = [Constants.ukApps[0], Constants.frApps[0], Constants.deApps[0],
                            Constants.ukApps[1], Constants.frApps[1], Constants.deApps[1],
                            Constants.ukApps[2], Constants.deApps[2],]
        let unsortedAppRowModels = unsortedApps.map { AppRowModel(appSummary: $0) }

        let sections = AppsSectionRowsModel.searchAndSort(from: unsortedAppRowModels, with: "BIP")
        
        // Expected result

        let expectedUk = AppsSectionRowsModel(store: Constants.stores["GB"]!,
                                              apps: [AppRowModel(appSummary: Constants.ukApps[2])])

        let expectedFr = AppsSectionRowsModel(store: Constants.stores["FR"]!,
                                              apps: [AppRowModel(appSummary: Constants.frApps[0])])

        let expectedDe = AppsSectionRowsModel(store: Constants.stores["DE"]!,
                                              apps: [AppRowModel(appSummary: Constants.deApps[2])])

        let expected = [expectedFr, expectedDe, expectedUk]

        XCTAssertEqual(sections, expected)
    }
}
