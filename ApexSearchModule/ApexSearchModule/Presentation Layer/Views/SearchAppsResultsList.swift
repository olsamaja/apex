//
//  SearchAppsResultsList.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 12/07/2021.
//
//  Issue: Text().lineLimit(n) Ignored Inside ScrollView
//  Source: https://swiftui-lab.com/bug-linelimit-ignored/
//  Description:
//    When we have a very long Text that needs more than one line to show its full contents,
//    the text will get truncated with an ellipsis, if inside a ScrollView.
//    Using .lineLimit(n) has no effect, for any value of n, including nil.
//  Solution:
//    Use .fixedSize(horizontal: false, vertical: true)

import SwiftUI
import ApexCore
import ApexCoreUI

struct SearchAppsResultsList: View {
    
    var items: [SearchResultRowModel]
    var viewModel: SearchAppsViewModel
    @State var selectedItem: SearchResultRowModel? = nil
    @State private var selectedApp: [AppSummary] = []
    
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    @EnvironmentObject var favorites: AppFavorites

    @ViewBuilder
    var body: some View {
        List {
            Section {
                ChangeStoreView(viewModel: viewModel)
            } header: {
                Text("Store")
            }
            Section {
                ForEach(items) { item in
                    Button {
                        let app = AppSummary(trackId: item.appDetails.trackId,
                                             trackName: item.appDetails.trackName,
                                             sellerName: item.appDetails.sellerName,
                                             storeCode: item.appDetails.storeCode)
                        self.favorites.add(app)
                        self.rootPresentationMode.wrappedValue.dismiss()
                    } label: {
                        SearchResultRow(item: item)
                            .foregroundColor(.black)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            } header: {
                Text("Apps")
            }
        }
    }
}

public class SearchApplicationsResultsListBuilder: BuilderProtocol {
    
    private var items: [SearchResultRowModel]?
    private var viewModel = SearchAppsViewModel(state: .idle)

    public func withItems(_ items: [SearchResultRowModel]) -> SearchApplicationsResultsListBuilder {
        self.items = items
        return self
    }
        
    public func withViewModel(_ viewModel: SearchAppsViewModel) -> SearchApplicationsResultsListBuilder {
        self.viewModel = viewModel
        return self
    }

    @ViewBuilder
    public func build() -> some View {
        if let items = items, items.count > 0 {
            SearchAppsResultsList(items: items, viewModel: viewModel)
        } else {
            MessageViewBuilder()
                .withMessage("No results")
                .build()
        }
    }
}
