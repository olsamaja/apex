//
//  SearchContentView.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 12/07/2021.
//

import SwiftUI
import ApexCoreUI
import ApexCore
import Resolver

public struct SearchContentView: View {
    
    @ObservedObject var viewModel: SearchViewModel

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

public class SearchContentViewBuilder: BuilderProtocol {
    
    private var viewModel: SearchViewModel?
    
    public func withViewModel(_ viewModel: SearchViewModel) -> SearchContentViewBuilder {
        self.viewModel = viewModel
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let viewModel = viewModel {
            SearchContentView(viewModel: viewModel)
        } else {
            EmptyView()
        }
    }
}

