//
//  SearchAppsView.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 25/11/2021.
//

import SwiftUI
import ApexCore
import ApexCoreUI
import ApexViewModule

//public final class SelectedApp: ObservableObject {
//    @Published var summary: AppSummary? = nil
//}
//
public struct SearchAppsView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: SearchAppsViewModel
    @EnvironmentObject var favorites: AppFavorites
    
    public init(viewModel: SearchAppsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        content
            .searchable(text: $viewModel.term, placement: .navigationBarDrawer(displayMode: .always))
            .navigationBarTitle(viewModel.store.name, displayMode: .inline)
//            .navigationDestination(for: SearchResultRowItem.self) { item in
//                AppView(viewModel: AppViewModel(appSummary: AppSummary(trackId: item.appDetails.trackId,
//                                                                       trackName: item.appDetails.trackName,
//                                                                       sellerName: item.appDetails.sellerName, storeCode: item.appDetails.storeCode)))
//            }
            .sheet(item: $viewModel.selectedApp, content: { appSummary in
                NavigationStack {
                    AppView(viewModel: AppViewModel(appSummary: appSummary))
                        .environmentObject(favorites)
                        .navigationBarTitle(appSummary.trackName)
                        .navigationBarItems(
                            leading:
                                Button("Cancel") {
                                    dismiss()
                                },
                            trailing:
                                Button("Add") {
                                    self.favorites.add(appSummary)
                                    dismiss()
                                }
                        )
                }
            })
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
