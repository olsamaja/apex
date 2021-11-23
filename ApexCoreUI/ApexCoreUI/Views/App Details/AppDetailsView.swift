//
//  AppDetailsView.swift
//  ApexCoreUI
//
//  Created by Olivier Rigault on 22/11/2021.
//

import SwiftUI
import ApexCore

public struct AppDetailsView: View {
    
    let viewModel: AppDetailsViewModel
    
    public init(viewModel: AppDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            HStack {
                Text(viewModel.version)
                Spacer()
                Text(viewModel.currentVersionReleaseDate)
            }
            Text(viewModel.averageUserRating)
            Text(viewModel.userRatingCountForCurrentVersion)
            Text(viewModel.minimumOsVersion)
            Text(viewModel.sellerName)
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
                                        currentVersionReleaseDate: Date(),
                                        minimumOsVersion: "14.0",
                                        averageUserRating: 4.83338,
                                        userRatingCountForCurrentVersion: 123456)
        static let model = AppDetailsViewModel(appDetails: Constants.details)
    }
    
    static var previews: some View {
        AppDetailsView(viewModel: Constants.model)
            .sizeThatFitPreview(with: "App Details")
    }
}
