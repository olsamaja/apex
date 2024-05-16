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

struct AppsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(viewModel: AppsViewModel())
    }
}
