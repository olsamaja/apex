//
//  SearchResultsList.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 12/07/2021.
//

import SwiftUI
import ApexCore
import ApexCoreUI
import ApexReviewsModule

struct SearchResultsList: View {
    
    var items: [SearchResultRowItem]
    @State var selectedItem: SearchResultRowItem? = nil
    
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    @EnvironmentObject var favorites: AppFavorites

    var body: some View {
        List {
            ForEach(items) { item in
                NavigationLink(destination: ReviewsView(viewModel: ReviewsViewModel(appDetails: item.appDetails)),
                               label: {
                    SearchResultRow(item: item)
                })
            }
        }
        .navigationBarItems(
            trailing:
                Button("Add") {
                    guard let item = selectedItem else { return }
                    
                    let app = AppSummary(trackId: item.appDetails.trackId,
                                         trackName: item.appDetails.trackName,
                                         sellerName: item.appDetails.sellerName,
                                         storeCode: item.appDetails.storeCode)
                    self.favorites.add(app)
                    self.rootPresentationMode.wrappedValue.dismiss()
                }
                .disabled(selectedItem == nil))
    }
}

public class SearchResultsListBuilder: BuilderProtocol {
    
    var items: [SearchResultRowItem]?

    public func withItems(_ items: [SearchResultRowItem]) -> SearchResultsListBuilder {
        self.items = items
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let items = items, items.count > 0 {
            SearchResultsList(items: items)
        } else {
            MessageViewBuilder()
                .withMessage("No results")
                .build()
        }
    }
}
