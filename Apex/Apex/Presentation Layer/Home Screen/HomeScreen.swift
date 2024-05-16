//
//  HomeScreen.swift
//  Apex
//
//  Created by Olivier Rigault on 22/12/2021.
//

import SwiftUI
import ApexCoreUI
import ApexCore
import ApexSearchModule
import ApexViewModule

struct HomeScreen: View {

    @ObservedObject var viewModel: AppsViewModel
    
    @State var showSelectApp = false
    @State var searchApps = ""
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>

    @ViewBuilder
    var body: some View {
        NavigationStack {
            AppsContentView(viewModel: viewModel, searchApps: searchApps)
                .searchable(text: $searchApps, placement: .navigationBarDrawer(displayMode: .always))
                .navigationTitle("Applications")
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Spacer()
                        Button("Add") {
                            self.showSelectApp.toggle()
                        }
                    }
                }
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
        .sheet(isPresented: $showSelectApp, content: {
            SearchAppsScreen(viewModel: SearchAppsViewModel())
                .environmentObject(viewModel.favorites)
        })
        .environment(\.rootPresentationMode, $showSelectApp)
        .ignoresSafeArea()
    }
}

#Preview("default") {
    HomeScreen(viewModel: AppsViewModel())
}

#Preview("error") {
    HomeScreen(viewModel: AppsViewModel(state: .error(.invalidResponse)))
}

#Preview("loading") {
    HomeScreen(viewModel: AppsViewModel(state: .loading))
}

#Preview("loaded") {
    HomeScreen(viewModel: AppsViewModel(state: .loaded([
        AppRowModel(appSummary: AppSummary(trackId: 0, trackName: "app 1", sellerName: "", storeCode: "FR")),
        AppRowModel(appSummary: AppSummary(trackId: 0, trackName: "app 2", sellerName: "", storeCode: "FR")),
        AppRowModel(appSummary: AppSummary(trackId: 0, trackName: "app 3", sellerName: "", storeCode: "FR")),
        AppRowModel(appSummary: AppSummary(trackId: 0, trackName: "app 4", sellerName: "", storeCode: "GB")),
        AppRowModel(appSummary: AppSummary(trackId: 0, trackName: "app 5", sellerName: "", storeCode: "GB"))])))
}
