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
    
    public init(viewModel: ReviewsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            AppDetailsView(viewModel: AppDetailsViewModel(appDetails: viewModel.appDetails))
            content
            Spacer()
        }
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

//struct ReviewsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewsView()
//    }
//}
