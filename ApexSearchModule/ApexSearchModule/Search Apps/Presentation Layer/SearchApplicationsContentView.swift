//
//  SearchApplicationsContentView.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 11/11/2023.
//

import SwiftUI
import ApexCoreUI
import ApexCore

public struct SearchApplicationsContentView: View {
    
    @StateObject var viewModel: SearchApplicationsViewModel

    public var body: some View {
        switch viewModel.state {
        case .idle:
            MessageViewBuilder()
                .withMessage("Search apps")
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
            SearchResultsListBuilder()
                .withItems(items)
                .build()
        case .searching:
            SpinnerBuilder()
                .withStyle(.large)
                .isAnimating(true)
                .build()
        }
    }
}

public class SearchApplicationsContentViewBuilder: BuilderProtocol {
    
    private var viewModel: SearchApplicationsViewModel?
    
    public func withViewModel(_ viewModel: SearchApplicationsViewModel) -> SearchApplicationsContentViewBuilder {
        self.viewModel = viewModel
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let viewModel = viewModel {
            SearchApplicationsContentView(viewModel: viewModel)
        } else {
            EmptyView()
        }
    }
}
