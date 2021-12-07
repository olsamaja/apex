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
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>

    var body: some View {
        List {
            ForEach(items) { item in
                SearchResultRow(item: item, selectedItem: $selectedItem)
            }
        }
        .navigationBarItems(
            trailing:
                Button("Add") {
                    OLLogger.info("Add \(selectedItem?.appDetails.trackName)")
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
