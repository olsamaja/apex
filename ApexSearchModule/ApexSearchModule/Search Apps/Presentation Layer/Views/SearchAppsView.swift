//
//  SearchAppsView.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 25/11/2021.
//

import SwiftUI
import ApexCore
import ApexCoreUI

public struct SearchAppsView: View {
    
    @ObservedObject var viewModel: SearchAppsViewModel

    public init(viewModel: SearchAppsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        SearchAppsContentViewBuilder()
            .withViewModel(viewModel)
            .build()
            .searchable(text: $viewModel.term, placement: .navigationBarDrawer(displayMode: .always))
            .navigationBarTitle(viewModel.store.name, displayMode: .inline)
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
