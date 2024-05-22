//
//  HomeContentView.swift
//  Apex
//
//  Created by Olivier Rigault on 21/05/2024.
//

import SwiftUI
import ApexCoreUI
import ApexCore

struct HomeContentView: View {
    
    @ObservedObject var viewModel: HomeViewModel

    public var body: some View {
        switch viewModel.state {
        case .idle:
            MessageViewBuilder()
                .withMessage("You have no favorites.")
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
                ForEach(AppsSectionModel.sort(from: items)) { section in
                    AppsSection(with: section)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        case .error:
            MessageViewBuilder()
                .withMessage("Cannot load favorites apps")
                .build()
        }
    }
}

public class HomeContentViewBuilder: BuilderProtocol {
    
    private var viewModel: HomeViewModel?
    
    public func withViewModel(_ viewModel: HomeViewModel) -> HomeContentViewBuilder {
        self.viewModel = viewModel
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let viewModel = viewModel {
            HomeContentView(viewModel: viewModel)
        } else {
            EmptyView()
        }
    }
}

#Preview {
    HomeContentView(viewModel: HomeViewModel(state: .idle))
}
