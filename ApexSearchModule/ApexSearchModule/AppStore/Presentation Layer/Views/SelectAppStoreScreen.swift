//
//  SelectAppStoreScreen.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 24/11/2021.
//

import SwiftUI
import ApexCore
import ApexStoreModule

public struct SelectAppStoreScreen: View {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: SelectAppStoreViewModel
    @State private var searchStore = ""

    public init(viewModel: SelectAppStoreViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.AppStoreSections(with: searchStore), id: \.self) { section in
                    Section(header: Text(section.title)) {
                        ForEach(section.stores, id: \.self) { store in
                            NavigationLink(value: store) {
                                    AppStoreRow(store: store, selectedStore: $viewModel.selectedStore)
                                }
                        }
                    }
                }
            }
            .navigationDestination(for: AppStore.self) { store in
                SearchAppsView(viewModel: SearchAppsViewModel(store: store))
            }
            .searchable(text: $searchStore, placement: .navigationBarDrawer(displayMode: .always))
            .navigationBarTitle("Select Store", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button("Cancel") {
                        dismiss()
                    }
            )
        }
    }
}

struct SelectAppStoreView_Previews: PreviewProvider {
    static var previews: some View {
        SelectAppStoreScreen(viewModel: SelectAppStoreViewModel())
    }
}
