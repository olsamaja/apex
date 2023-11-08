//
//  AppView.swift
//  Apex
//
//  Created by Olivier Rigault on 04/01/2022.
//

import SwiftUI
import ApexCore
import ApexCoreUI

public struct AppView: View {
    
    @ObservedObject var viewModel: AppViewModel

    public init(viewModel: AppViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
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
        case .loadedDetailsAndReviews(let sections):
            List {
                ForEach(sections) { section in
                    SectionRows(with: section)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        case .loading:
            SpinnerBuilder()
                .withStyle(.large)
                .isAnimating(true)
                .build()
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(viewModel: AppViewModel(appSummary: AppSummary(trackId: 1234, trackName: "My App", sellerName: "Seller", storeCode: "Store")))
    }
}
