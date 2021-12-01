//
//  SelectAppStoreView.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 24/11/2021.
//

import SwiftUI
import ApexCore

public struct SelectAppStoreView: View {

    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>

    let viewModel: SelectAppStoreViewModel
    @State var selectedStore: AppStore? = AppStoreManager.defaultStore

    public init(viewModel: SelectAppStoreViewModel) {
        self.viewModel = viewModel
    }
    
    @ViewBuilder
    public var body: some View {
        NavigationView {
            List(viewModel.stores, id: \.self) { store in
                AppStoreRow(store: store, selectedStore: $selectedStore)
            }
            .navigationBarTitle(Text("Select Country"), displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button("Cancel") {
                        self.presentationMode.wrappedValue.dismiss()
                    },
                trailing:
                    searchAppsView(store: selectedStore)
            )
        }
    }
    
    @ViewBuilder
    private func searchAppsView(store: AppStore?) -> some View {
        if let selectedStore = selectedStore {
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
