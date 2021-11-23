//
//  AppDetailsViewModel.swift
//  ApexCoreUI
//
//  Created by Olivier Rigault on 22/11/2021.
//

import Foundation
import ApexCore

public struct AppDetailsViewModel {
    
    let appDetails: AppDetails
    
    public init(appDetails: AppDetails) {
        self.appDetails = appDetails
    }
    
    var version: String {
        get {
            "Version " + appDetails.version
        }
    }
    
    var currentVersionReleaseDate: String {
        get {
            appDetails.currentVersionReleaseDate.toString()
        }
    }
    
    var userRatingCountForCurrentVersion: String {
        get {
            String(appDetails.userRatingCountForCurrentVersion)
        }
    }
    
    var averageUserRating: String {
        get {
            String(appDetails.averageUserRating)
        }
    }
    
    var sellerName: String {
        get {
            appDetails.sellerName
        }
    }

    var minimumOsVersion: String {
        get {
            "iOS " + appDetails.minimumOsVersion
        }
    }
}
