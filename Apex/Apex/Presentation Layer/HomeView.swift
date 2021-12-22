//
//  HomeView.swift
//  Apex
//
//  Created by Olivier Rigault on 22/12/2021.
//

import SwiftUI
import ApexCoreUI
import ApexCore
import ApexSearchModule

struct HomeView: View {

    @ObservedObject var viewModel: AppsViewModel
    
    @State var showSelectStore = false
    @State var searchApps = ""
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>

    var body: some View {
        NavigationView {
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
        }
        .sheet(isPresented: $showSelectStore, content: {
            SelectAppStoreView(viewModel: SelectAppStoreViewModel())
                .environmentObject(viewModel.favorites)
        })
        .environment(\.rootPresentationMode, $showSelectStore)
        .ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: AppsViewModel())
    }
}
