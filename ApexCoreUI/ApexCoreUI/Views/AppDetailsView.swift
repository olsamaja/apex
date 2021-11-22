//
//  AppDetailsView.swift
//  ApexCoreUI
//
//  Created by Olivier Rigault on 22/11/2021.
//

import SwiftUI
import ApexCore

public struct AppDetailsView: View {
    
    let appDetails: AppDetails
    
    public init(appDetails: AppDetails) {
        self.appDetails = appDetails
    }
    
    public var body: some View {
        VStack {
            Text(appDetails.sellerName)
            Text(appDetails.version)
            Text(appDetails.currentVersionReleaseDate)
            Text(String(appDetails.averageUserRating))
            Text(String(appDetails.userRatingCountForCurrentVersion))
            Text(appDetails.minimumOsVersion)
        }
        .padding(.vertical)
    }
}

struct AppDetailsView_Previews: PreviewProvider {
    
    enum Constants {
        static let details = AppDetails(trackId: 0,
                                        trackName: "Amazing App",
                                        sellerName: "Amazing Publisher Ltd",
                                        version: "1.2.3",
                                        currentVersionReleaseDate: "2021-11-15T12:30:38Z",
                                        minimumOsVersion: "14.0",
                                        averageUserRating: 4.83338,
                                        userRatingCountForCurrentVersion: 123456)
    }
    
    static var previews: some View {
        AppDetailsView(appDetails: Constants.details)
            .sizeThatFitPreview(with: "App Details")
    }
}
