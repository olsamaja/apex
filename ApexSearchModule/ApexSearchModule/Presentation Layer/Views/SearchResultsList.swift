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
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(items) { item in
                    NavigationLink(
                        destination: ReviewsViewBuilder()
                            .withViewModel(ReviewsViewModel(appId: item.trackId))
                            .build(),
                        label: {
                            SearchResultRowBuilder()
                                .withItem(item)
                                .build()
                        }
                    )
                }
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
        if let items = items {
            SearchResultsList(items: items)
        } else {
            EmptyView()
        }
    }
}
