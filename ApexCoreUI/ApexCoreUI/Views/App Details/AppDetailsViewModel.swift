//
//  AppDetailsViewModel.swift
//  ApexCoreUI
//
//  Created by Olivier Rigault on 22/11/2021.
//

import Foundation
import ApexCore

enum AppDetailType {
    case version
    case currentVersionReleaseDate
    case averageUserRating
    case userRatingCountForCurrentVersion
    case minimumOsVersion
    case seller
    case unknown
    
    var string: String {
        switch self {
        case .version:
            return "Version"
        case .currentVersionReleaseDate:
            return "Updated"
        case .averageUserRating:
            return "Average Rating"
        case .userRatingCountForCurrentVersion:
            return "Ratings"
        case .minimumOsVersion:
            return "Minimum OS Version"
        case .seller:
            return "Developer"
        case .unknown:
            return "Not specified"
        }
    }
}

struct AppDetailItem {
    
    let type: AppDetailType
    let value: String
    
    init(_ type: AppDetailType, _ value: String) {
        self.type = type
        self.value = value
    }
    
    var title: String {
        get {
            type.string
        }
    }
}

extension AppDetailItem: Hashable {}

public struct AppDetailsViewModel {
    
    let appDetails: AppDetails
    
    func details() -> [AppDetailItem] {
        [
            AppDetailItem(.version, appDetails.version),
            AppDetailItem(.currentVersionReleaseDate, appDetails.currentVersionReleaseDate.toString()),
            AppDetailItem(.userRatingCountForCurrentVersion, String(appDetails.userRatingCountForCurrentVersion)),
            AppDetailItem(.averageUserRating, String(format: "%.1f", appDetails.averageUserRating)),
            AppDetailItem(.minimumOsVersion, "iOS " + appDetails.minimumOsVersion),
            AppDetailItem(.seller, appDetails.sellerName)
        ]
    }
    
    public init(appDetails: AppDetails) {
        self.appDetails = appDetails
    }
}
