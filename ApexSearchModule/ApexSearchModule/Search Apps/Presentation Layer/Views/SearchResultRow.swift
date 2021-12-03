//
//  SearchResultRow.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 12/07/2021.
//

import SwiftUI
import ApexCore
import ApexCoreUI

struct SearchResultRow: View {

    var item: SearchResultRowItem
    
    var body: some View {
        HStack {
            Image(systemName: "person")
                .font(.callout)
            HStack {
                VStack(alignment: .leading) {
                    Text(item.appDetails.trackName)
                        .font(.title3)
                    Text(item.appDetails.sellerName)
                        .font(.callout)
                }
                Spacer()
                RatingViewBuilder()
                    .withRating(item.appDetails.averageUserRating)
                    .build()
            }
            Image(systemName: "checkmark")
                .foregroundColor(.accentColor)
        }
        .padding(.vertical)
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
    
    enum Constants {
        static let app1 = AppDetails(trackId: 12456,
                                     trackName: "Track name",
                                     sellerName: "Seller's name",
                                     version: "1.2.3",
                                     currentVersionReleaseDate: Date(),
                                     minimumOsVersion: "13.0",
                                     averageUserRating: 4.7655,
                                     userRatingCountForCurrentVersion: 123456,
                                     storeCode: "FR")
        static let app2 = AppDetails(trackId: 12456,
                                     trackName: "This is a very long application name",
                                     sellerName: "Seller's name",
                                     version: "1.2.3",
                                     currentVersionReleaseDate: Date(),
                                     minimumOsVersion: "13.0",
                                     averageUserRating: 4.7655,
                                     userRatingCountForCurrentVersion: 123456,
                                     storeCode: "FR")
        static let app3 = AppDetails(trackId: 12456,
                                     trackName: "Track name",
                                     sellerName: "This is a very long seller's name, and very unlikely to be seen in the real world (c)",
                                     version: "1.2.3",
                                     currentVersionReleaseDate: Date(),
                                     minimumOsVersion: "13.0",
                                     averageUserRating: 4.7655,
                                     userRatingCountForCurrentVersion: 123456,
                                     storeCode: "FR")
    }
    
    static var previews: some View {
        Group {
            SearchResultRow(item: SearchResultRowItem(appDetails: Constants.app1))
                .sizeThatFitPreview(with: "Default")
            SearchResultRow(item: SearchResultRowItem(appDetails: Constants.app2))
                .sizeThatFitPreview(with: "Long application name")
            SearchResultRow(item: SearchResultRowItem(appDetails: Constants.app3))
                .sizeThatFitPreview(with: "Long seller's name")
        }
    }
}
