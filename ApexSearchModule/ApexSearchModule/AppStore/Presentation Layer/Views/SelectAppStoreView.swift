//
//  SelectAppStoreView.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 24/11/2021.
//

import SwiftUI
import ApexCore
import ApexStoreModule
import UIPilot

enum SearchRoute: Equatable {
    case searchStore
    case selectStore(AppStore)
    case details(AppSummary)
}

public struct SelectAppStoreView: View {

    @Environment(\.dismiss) var dismiss
    @StateObject var pilot = UIPilot(initial: SearchRoute.searchStore)
    @ObservedObject var viewModel: SelectAppStoreViewModel
    @State private var searchStore = ""

    public init(viewModel: SelectAppStoreViewModel) {
        self.viewModel = viewModel
        OLLogger.info("SelectAppStoreView()")
    }
    
    public var body: some View {
        UIPilotHost(pilot) { route in
            switch route {
            case .searchStore:
                List {
                    ForEach(viewModel.AppStoreSections(with: searchStore), id: \.self) { section in
                        Section(header: Text(section.title)) {
                            ForEach(section.stores, id: \.self) { store in
                                Button(store.name) {
                                    pilot.push(.selectStore(store))
                                }
//                                NavigationLink(value: store) {
//                                        AppStoreRow(store: store, selectedStore: $viewModel.selectedStore)
//                                    }
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
            case .selectStore(let store):
                SearchAppsView(viewModel: SearchAppsViewModel(store: store))
            case .details(let appSummary):
                Text(appSummary.trackName)
            }
        }
    }
}

struct SelectStoreView_Previews: PreviewProvider {
    static var previews: some View {
        SelectAppStoreView(viewModel: SelectAppStoreViewModel())
    }
}
