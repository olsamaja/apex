//
//  AppsContentView.swift
//  Apex
//
//  Created by Olivier Rigault on 14/12/2021.
//

import SwiftUI
import ApexCoreUI
import ApexCore

struct AppsContentView: View {
    
    @ObservedObject var viewModel: AppsViewModel

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
                ForEach(items) { item in
                    AppRow(item: item)
                }
            }
        case .error:
            MessageViewBuilder()
                .withMessage("Cannot load favorites")
                .build()
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
