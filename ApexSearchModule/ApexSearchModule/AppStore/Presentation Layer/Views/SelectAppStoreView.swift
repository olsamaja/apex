//
//  SelectAppStoreView.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 24/11/2021.
//

import SwiftUI
import ApexCore
import ApexStoreModule

public struct SelectAppStoreView: View {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: SelectAppStoreViewModel
    @State private var searchStore = ""

    public init(viewModel: SelectAppStoreViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.AppStoreSections(with: searchStore), id: \.self) { section in
                    Section(header: Text(section.title)) {
                        ForEach(section.stores, id: \.self) { store in
                            NavigationLink(
                                destination: SearchAppsView(viewModel: SearchAppsViewModel(store: store)),
                                label: {
                                    AppStoreRow(store: store, selectedStore: $viewModel.selectedStore)
                                })
                        }
                    }
                }
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

struct SelectStoreView_Previews: PreviewProvider {
    static var previews: some View {
        SelectAppStoreView(viewModel: SelectAppStoreViewModel())
    }
}
