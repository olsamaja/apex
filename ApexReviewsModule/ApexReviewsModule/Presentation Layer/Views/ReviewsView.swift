//
//  ReviewsView.swift
//  ApexReviewsModule
//
//  Created by Olivier Rigault on 10/07/2021.
//

import SwiftUI
import ApexCore
import ApexCoreUI

public struct ReviewsView: View {
    
    @ObservedObject var viewModel: ReviewsViewModel
    
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    @EnvironmentObject var favorites: AppFavorites

    public init(viewModel: ReviewsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            AppDetailsViewBuilder()
                .withViewModel(AppDetailsViewModel(appDetails: AppDetails(trackId: viewModel.appSummary.trackId, trackName: viewModel.appSummary.trackName, sellerName: viewModel.appSummary.sellerName, version: "version", currentVersionReleaseDate: Date(), minimumOsVersion: "iOS 16.0", averageUserRating: 1.23, userRatingCountForCurrentVersion: 1234, storeCode: viewModel.appSummary.storeCode)))
                .build()
            content
            Spacer()
        }
        .navigationTitle(viewModel.appSummary.trackName)
        .navigationBarItems(
            trailing:
                Button {
                    let appDetails = viewModel.appSummary
                    let appSummary = AppSummary(trackId: appDetails.trackId,
                                                trackName: appDetails.trackName,
                                                sellerName: appDetails.sellerName,
                                                storeCode: appDetails.storeCode)
                    self.favorites.add(appSummary)
                    self.rootPresentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "heart")
                }
            )
    }
    
    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .idle:
            MessageViewBuilder()
                .withMessage("Loading reviews")
                .withAlignment(.top)
                .build()
                .onAppear {
                    viewModel.send(event: .onAppear)
                }
        case .error(let error):
            MessageViewBuilder()
                .withSymbol("xmark.octagon")
                .withMessage(error.localizedDescription)
                .build()
        case .loaded(let items):
            ReviewsListBuilder()
                .withItems(items)
                .build()
        case .loading:
            SpinnerBuilder()
                .withStyle(.large)
                .isAnimating(true)
                .build()
        }
    }
}

public class ReviewsViewBuilder: BuilderProtocol {
    
    private var viewModel: ReviewsViewModel?

    public init() {}
    
    public func withViewModel(_ viewModel: ReviewsViewModel) -> ReviewsViewBuilder {
        self.viewModel = viewModel
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let viewModel = viewModel {
            ReviewsView(viewModel: viewModel)
        } else {
            EmptyView()
        }
    }
}
//
//struct ReviewsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewsView(viewModel: ReviewsViewModel(appDetails: AppDetails(trackId: <#T##Int#>, trackName: <#T##String#>, sellerName: <#T##String#>, version: <#T##String#>, currentVersionReleaseDate: <#T##Date#>, minimumOsVersion: <#T##String#>, averageUserRating: <#T##Double#>, userRatingCountForCurrentVersion: <#T##Int#>, storeCode: <#T##String#>), state: <#T##ReviewsViewModel.State#>))
//    }
//}
