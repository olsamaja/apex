//
//  SearchAppsContentView.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 25/11/2021.
//

import SwiftUI
import ApexCoreUI
import ApexCore
import Resolver

public struct SearchAppsContentView: View {
    
    @ObservedObject var viewModel: SearchAppsViewModel

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

public class SearchAppsContentViewBuilder: BuilderProtocol {
    
    private var viewModel: SearchAppsViewModel?
    
    public func withViewModel(_ viewModel: SearchAppsViewModel) -> SearchAppsContentViewBuilder {
        self.viewModel = viewModel
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let viewModel = viewModel {
            SearchAppsContentView(viewModel: viewModel)
        } else {
            EmptyView()
        }
    }
}

