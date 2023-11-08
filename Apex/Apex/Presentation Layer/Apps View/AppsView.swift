//
//  AppsView.swift
//  Apex
//
//  Created by Olivier Rigault on 22/12/2021.
//

import SwiftUI
import ApexCoreUI
import ApexCore
import ApexSearchModule
import ApexViewModule

struct AppsView: View {

    @ObservedObject var viewModel: AppsViewModel
    
    @State var showSelectStore = false
    @State var searchApps = ""
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>

    @ViewBuilder
    var body: some View {
        NavigationStack {
            AppsContentView(viewModel: viewModel, searchApps: searchApps)
                .searchable(text: $searchApps, placement: .navigationBarDrawer(displayMode: .always))
                .navigationTitle("Applications")
                .toolbar {
                    Button {
                        self.showSelectStore.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .navigationDestination(for: AppRowItem.self) { item in
                    AppView(viewModel: AppViewModel(appSummary: item.appSummary))
                }
                .navigationDestination(for: AppContentRowModel.self) { model in
                    switch model.category {
                    case .review(let model):
                        AppReviewRow(item: model)
                    default:
                        EmptyView()
                    }
                }
        }
        .sheet(isPresented: $showSelectStore, content: {
            SelectAppStoreView(viewModel: SelectAppStoreViewModel())
                .environmentObject(viewModel.favorites)
        })
        .environment(\.rootPresentationMode, $showSelectStore)
        .ignoresSafeArea()
    }
}

struct AppsView_Previews: PreviewProvider {
    static var previews: some View {
        AppsView(viewModel: AppsViewModel())
    }
}
