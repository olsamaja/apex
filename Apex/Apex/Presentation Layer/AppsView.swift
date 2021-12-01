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
import Resolver

struct AppsView: View {

    @Injected var viewModel: AppsViewModel
    @State var showSelectStore = false

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
            })
            .ignoresSafeArea()
    }
    
    private var content: some View {
        MessageViewBuilder()
            .withMessage("Add an application")
            .withAlignment(.top)
            .build()
    }
}

struct AppsView_Previews: PreviewProvider {
    
    enum Dependencies {
        static var registerIdleState = { () -> Bool in
            Resolver.register { AppsViewModel() as AppsViewModel }
            return true
        }
    }
    
    static var previews: some View {
        Group {
            if Dependencies.registerIdleState() {
                AppsView()
                    .previewDisplayName("default state = .idle")
            }
        }
    }
}
