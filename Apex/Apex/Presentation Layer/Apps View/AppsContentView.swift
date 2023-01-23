//
//  AppsContentView.swift
//  Apex
//
//  Created by Olivier Rigault on 14/12/2021.
//

import SwiftUI
import ApexCoreUI
import ApexCore
import UIPilot

struct AppsContentView: View {
    
    @EnvironmentObject var pilot: UIPilot<AppRoute>
    @ObservedObject var viewModel: AppsViewModel
    var searchApps = ""

    @ViewBuilder
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
            if items.count > 0 {
                List {
                    ForEach(searchResults(from: items, with: searchApps)) { item in
                        Button(item.trackName) {
                            pilot.push(.details(item.appSummary))
                        }
                    }
                }
            } else {
                MessageViewBuilder()
                    .withMessage("Please add a new application")
                    .withAlignment(.top)
                    .build()
            }
        case .error:
            MessageViewBuilder()
                .withMessage("Cannot load favorites")
                .withSymbol("xmark.octagon")
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
