//
//  AppsView.swift
//  Apex
//
//  Created by Olivier Rigault on 24/11/2021.
//

import SwiftUI
import ApexCoreUI
import ApexCore
import ApexSearchModule

struct AppsView: View {

    @ObservedObject var viewModel: AppsViewModel
    
    @State var showSelectStore = false
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>

    public var body: some View {
        SearchNavigationViewBuilder()
            .withContentView(content)
            .withTitle("Applications")
            .withPlaceholder("Search")
            .onSearch { (searchTerm) in
                viewModel.search(with: searchTerm)
            }
            .withBarButtonItemImage("plus")
            .onBarButtonItem {
                self.showSelectStore = true
            }
            .build()
            .sheet(isPresented: $showSelectStore, content: {
                SelectAppStoreView(viewModel: SelectAppStoreViewModel())
                    .environmentObject(viewModel.favorites)
            })
            .environment(\.rootPresentationMode, $showSelectStore)
            .ignoresSafeArea()
    }
    
    private var content: some View {
        AppsContentViewBuilder()
            .withViewModel(viewModel)
            .build()
    }
}

struct AppsView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            AppsView(viewModel: AppsViewModel())
                .previewDisplayName("default state = .idle")
        }
    }
}
