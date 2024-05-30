//
//  HomeScreen.swift
//  Apex
//
//  Created by Olivier Rigault on 21/05/2024.
//

import SwiftUI
import ApexCoreUI
import ApexCore
import ApexSearchModule
import ApexViewModule

struct HomeScreen: View {

    @ObservedObject var viewModel: HomeViewModel
    
    @ViewBuilder
    var body: some View {
        NavigationStack {
            HomeContentView(viewModel: viewModel)
                .navigationTitle("Apex")
                .navigationDestination(for: AppRowModel.self) { item in
                    AppScreen(viewModel: AppViewModel(appSummary: item.appSummary))
                }
                .navigationDestination(for: ContentRowModel.self) { model in
                    switch model.category {
                    case .review(let model):
                        ReviewScreen(model: model)
                    default:
                        EmptyView()
                    }
                }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HomeScreen(viewModel: HomeViewModel(state: .idle, storedApps: .constant(StoredApps(apps: []))))
}
