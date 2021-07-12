//
//  SearchResultsList.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 12/07/2021.
//

import SwiftUI
import ApexCore

struct SearchResultsList: View {
    
    var items: [SearchResultRowItem]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(items) { item in
                    SearchResultRowBuilder()
                        .withItem(item)
                        .build()
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

//struct SearchResultsList_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchResultsList()
//    }
//}
