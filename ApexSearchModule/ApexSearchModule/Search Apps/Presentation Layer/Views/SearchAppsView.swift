//
//  SearchAppsView.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 25/11/2021.
//

import SwiftUI

import SwiftUI
import ApexCoreUI
import ApexCore
import Resolver
import ApexSettingsModule

public struct SearchAppsView: View {
    
    let viewModel: SearchAppsViewModel
    @State var searchTerm: String = ""

    public init(viewModel: SearchAppsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        SearchNavigationViewBuilder()
            .withContentView(AnyView(content))
            .withPlaceholder("Search")
            .onSearch { (searchTerm) in
                viewModel.search(with: searchTerm)
            }
            .build()
            .ignoresSafeArea()
    }
    
    private var content: some View {
        SearchAppsContentViewBuilder()
            .withViewModel(viewModel)
            .build()
    }
}

struct SearchAppsView_Previews: PreviewProvider {
    
    enum Constants {
        static let store = AppStore(code: "FR", name: "France")
        static let model = SearchAppsViewModel(state: .idle, store: Constants.store)
    }
    
    static var previews: some View {
        Group {
            SearchAppsView(viewModel: Constants.model)
                .previewDisplayName("default state = .idle")
        }
    }
}
