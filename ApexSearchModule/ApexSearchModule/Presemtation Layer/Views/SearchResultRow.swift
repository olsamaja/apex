//
//  SearchResultRow.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 12/07/2021.
//

import SwiftUI
import ApexCore

struct SearchResultRow: View {

    var item: SearchResultRowItem
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person")
                    .font(.callout)
                VStack(alignment: .leading) {
                    HStack {
                        Text(item.trackName)
                            .font(.title3)
                        Spacer()
                    }
                    HStack {
                        Text(item.sellerName)
                            .font(.callout)
                        Spacer()
                    }
                }
            }
        }
        .padding()
    }
}

public class SearchResultRowBuilder: BuilderProtocol {
    
    private var item: SearchResultRowItem?

    public func withItem(_ item: SearchResultRowItem) -> SearchResultRowBuilder {
        self.item = item
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let item = item {
            SearchResultRow(item: item)
        } else {
            EmptyView()
        }
    }
}

struct SearchResultRow_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultRow(item:
                            SearchResultRowItem(trackId: 12456,
                                                trackName: "Track name",
                                                sellerName: "Seller's name",
                                                version: "1.2.3",
                                                currentVersionReleaseDate: "date",
                                                minimumOsVersion: "iOS 13.0",
                                                averageUserRating: 123456))
            .sizeThatFitPreview(with: "Default")
    }
}
