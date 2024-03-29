//
//  SearchResultsList.swift
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

struct SearchResultsList: View {
    
    var items: [SearchResultRowItem]
    @State var selectedItem: SearchResultRowItem? = nil
    
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    @EnvironmentObject var favorites: AppFavorites

    var body: some View {
        List {
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
