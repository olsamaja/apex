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

#if DEBUG
#Preview {
    HomeContentView(viewModel: HomeViewModel(state: .idle, 
                                             storedApps: .constant(StoredApps(apps: [
                                                AppSummary(trackId: 0, trackName: "app 1", sellerName: "", storeCode: "", isFavorite: true),
                                                AppSummary(trackId: 0, trackName: "app 2", sellerName: "", storeCode: "", isFavorite: true)]))))
}
#endif
