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
    
    var body: some View {
        List {
            ForEach(items) { item in
                NavigationRow(destination: {
                    ReviewsViewBuilder()
                        .withViewModel(ReviewsViewModel(appDetails: item.appDetails))
                        .build()
                        .navigationBarTitle(item.appDetails.trackName, displayMode: .inline)
                }, label: {
                    SearchResultRowBuilder()
                        .withItem(item)
                        .build()
                })
            }
        }
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
