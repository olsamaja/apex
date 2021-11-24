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
        HStack {
            VStack(alignment: .leading) {
                ForEach(viewModel.details(), id: \.self) { detail in
                    DetailView(title: detail.title, value: detail.value)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
            }
            Spacer()
        }
        .padding()
    }
}

public class AppDetailsViewBuilder: BuilderProtocol {
    
    private var viewModel: AppDetailsViewModel?

    public init() {}
    
    public func withViewModel(_ viewModel: AppDetailsViewModel) -> AppDetailsViewBuilder {
        self.viewModel = viewModel
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let viewModel = viewModel {
            AppDetailsView(viewModel: viewModel)
        } else {
            EmptyView()
        }
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
                                        userRatingCountForCurrentVersion: 123456,
                                        storeCode: "GB")
        static let model = AppDetailsViewModel(appDetails: Constants.details)
    }
    
    static var previews: some View {
        AppDetailsViewBuilder()
            .withViewModel(Constants.model)
            .build()
            .sizeThatFitPreview(with: "App Details")
    }
}
