//
//  AppsScreen.swift
//  Apex
//
//  Created by Olivier Rigault on 22/12/2021.
//

import SwiftUI
import ApexCoreUI
import ApexCore
import ApexSearchModule
import ApexViewModule

struct AppsScreen: View {

    @ObservedObject var viewModel: AppsViewModel
    
    @State var showSelectApp = false
    @State var searchApps = ""
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>

    @ViewBuilder
    var body: some View {
        NavigationStack {
            AppsContentView(viewModel: viewModel, searchApps: searchApps)
                .searchable(text: $searchApps, placement: .navigationBarDrawer(displayMode: .always))
                .autocorrectionDisabled(true)
                .navigationTitle("Applications")
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button("Add New") {
                            self.viewModel.addApplication.toggle()
                        }
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
        .sheet(isPresented: $viewModel.addApplication, content: {
            SearchAppsScreen(viewModel: SearchAppsViewModel())
                .environmentObject(viewModel.storedApps)
        })
        .sheet(isPresented: $showSelectApp, content: {
            SearchAppsScreen(viewModel: SearchAppsViewModel())
                .environmentObject(viewModel.storedApps)
        })
        .environment(\.rootPresentationMode, $showSelectApp)
        .ignoresSafeArea()
    }
}

#Preview("default") {
    AppsScreen(viewModel: AppsViewModel(storedApps: .constant(StoredApps(apps: []))))
}

#Preview("error") {
    AppsScreen(viewModel: AppsViewModel(state: .error(.invalidResponse), storedApps: .constant(StoredApps(apps: []))))
}

#Preview("loading") {
    AppsScreen(viewModel: AppsViewModel(state: .loading, storedApps: .constant(StoredApps(apps: []))))
}

#Preview("loaded") {
    AppsScreen(viewModel: AppsViewModel(state: .loaded([
        AppRowModel(appSummary: AppSummary(trackId: 0, trackName: "app 1", sellerName: "", storeCode: "FR")),
        AppRowModel(appSummary: AppSummary(trackId: 0, trackName: "app 2", sellerName: "", storeCode: "FR", isFavorite: true)),
        AppRowModel(appSummary: AppSummary(trackId: 0, trackName: "app 3", sellerName: "", storeCode: "FR", isFavorite: true)),
        AppRowModel(appSummary: AppSummary(trackId: 0, trackName: "app 4", sellerName: "", storeCode: "GB", isFavorite: true)),
        AppRowModel(appSummary: AppSummary(trackId: 0, trackName: "app 5", sellerName: "", storeCode: "GB"))]),
                                        storedApps: .constant(StoredApps(apps: [
                                            AppSummary(trackId: 0, trackName: "app 1", sellerName: "", storeCode: "FR")]))))
}