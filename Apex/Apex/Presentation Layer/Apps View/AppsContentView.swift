//
//  AppsContentView.swift
//  Apex
//
//  Created by Olivier Rigault on 14/12/2021.
//

import SwiftUI
import ApexCoreUI
import ApexCore
import ApexViewModule

struct AppsContentView: View {
    
    @ObservedObject var viewModel: AppsViewModel
    var searchApps = ""

    public var body: some View {
        switch viewModel.state {
        case .idle:
            MessageViewBuilder()
                .withMessage("Add an application")
                .withAlignment(.top)
                .build()
                .onAppear {
                    viewModel.send(event: .onAppear)
                }
        case .loading:
            MessageViewBuilder()
                .withMessage("Loading")
                .build()
        case .loaded(let items):
            List {
                ForEach(searchResults(from: items, with: searchApps)) { item in
                    NavigationLink(destination: AppView(viewModel: AppViewModel(appSummary: item.appSummary)),
                                   label: {
                        AppRow(item: item)
                    })
                }
            }
//            List {
//                ForEach(searchResults(from: items, with: searchApps)) { item in
//                    NavigationLink(destination: ReviewsView(viewModel: ReviewsViewModel(appSummary: item.appSummary)),
//                                   label: {
//                        AppRow(item: item)
//                    })
//                }
//            }
        case .error:
            MessageViewBuilder()
                .withMessage("Cannot load favorites")
                .build()
        }
    }
    
    private func searchResults(from items: [AppRowItem], with term: String) -> [AppRowItem] {
        if term.isEmpty {
            return items
        } else {
            return items.filter { $0.trackName.contains(term) || $0.storeCode.contains(term) }
        }
    }
}

public class AppsContentViewBuilder: BuilderProtocol {
    
    private var viewModel: AppsViewModel?
    
    public func withViewModel(_ viewModel: AppsViewModel) -> AppsContentViewBuilder {
        self.viewModel = viewModel
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let viewModel = viewModel {
            AppsContentView(viewModel: viewModel)
        } else {
            EmptyView()
        }
    }
}
