//
//  SelectAppStoreView.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 24/11/2021.
//

import SwiftUI
import ApexCore

public struct SelectAppStoreView: View {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: SelectAppStoreViewModel
    @State private var searchStore = ""

    public init(viewModel: SelectAppStoreViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationView {
            List(searchResults, id: \.self) { store in
                AppStoreRow(store: store, selectedStore: $viewModel.selectedStore)
            }
            .searchable(text: $searchStore, placement: .navigationBarDrawer(displayMode: .always))
            .navigationBarTitle("Select Country", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button("Cancel") {
                        dismiss()
                    },
                trailing:
                    searchAppsView(store: viewModel.selectedStore)
            )
        }
    }
    
    var searchResults: [AppStore] {
        if searchStore.isEmpty {
            return viewModel.stores
        } else {
            return viewModel.stores.filter { $0.name.contains(searchStore) }
        }
    }
    
    @ViewBuilder
    private func searchAppsView(store: AppStore?) -> some View {
        if let selectedStore = viewModel.selectedStore {
                NavigationLink(
                    destination: SearchAppsView(viewModel: SearchAppsViewModel(state: .idle, store: selectedStore)),
                    label: {
                        Text("Next")
                    })
                .disabled(store == nil)
        } else {
            EmptyView()
        }
    }
}

struct SelectStoreView_Previews: PreviewProvider {
    static var previews: some View {
        SelectAppStoreView(viewModel: SelectAppStoreViewModel())
    }
}
