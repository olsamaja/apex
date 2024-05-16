//
//  SearchAppsContentView.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 11/11/2023.
//
//  Source:
//  - https://stackoverflow.com/questions/58384580/how-do-you-create-a-swiftui-view-that-takes-an-optional-secondary-view-argument

import SwiftUI
import ApexCoreUI
import ApexCore
import ApexStoreModule

public struct SearchAppsContentView: View {
    
    @StateObject var viewModel: SearchAppsViewModel

    public var body: some View {
        switch viewModel.state {
        case .idle:
            HeaderRowAndContentView("Store") {
                ChangeStoreView(viewModel: viewModel)
            }
        case .error(let error):
            HeaderRowAndContentView {
                ChangeStoreView(viewModel: viewModel)
            } content: {
                VStack {
                    Spacer()
                    MessageViewBuilder()
                        .withSymbol("xmark.octagon")
                        .withMessage(error.description)
                        .build()
                    Spacer()
                }
            }
        case .loaded(let items):
            SearchApplicationsResultsListBuilder()
                .withItems(items)
                .withViewModel(viewModel)
                .build()
        case .searching:
            HeaderRowAndContentView {
                ChangeStoreView(viewModel: viewModel)
            } content: {
                SpinnerBuilder()
                    .withStyle(.large)
                    .isAnimating(true)
                    .build()
                    .background(Color(UIColor.systemGroupedBackground))
            }
        }
    }
}

public class SearchApplicationsContentViewBuilder: BuilderProtocol {
    
    private var viewModel: SearchAppsViewModel?
    
    public func withViewModel(_ viewModel: SearchAppsViewModel) -> SearchApplicationsContentViewBuilder {
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

struct SearchApplicationsContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            SearchApplicationsContentViewBuilder()
                .withViewModel(SearchAppsViewModel(state: .idle))
                .build()
                .previewDisplayName("default state = .idle")
            SearchApplicationsContentViewBuilder()
                .withViewModel(SearchAppsViewModel(state: .error(.invalidResponse)))
                .build()
                .previewDisplayName("default state = .error")
        }
    }
}
