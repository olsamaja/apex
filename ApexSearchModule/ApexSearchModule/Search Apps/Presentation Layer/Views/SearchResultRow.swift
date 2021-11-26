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
        VStack {
            HStack {
                Image(systemName: "person")
                    .font(.callout)
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(item.appDetails.trackName)
                                .font(.title3)
                            Spacer()
                            RatingViewBuilder()
                                .withRating(item.appDetails.averageUserRating)
                                .build()
                        }
                        HStack {
                            Text(item.appDetails.sellerName)
                                .font(.callout)
                            Spacer()
                            BadgeViewBuilder()
                                .withInt(item.appDetails.userRatingCountForCurrentVersion)
                                .build()
                        }
                    }
                    Spacer()
                }
            }
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
        static let result = AppDetails(trackId: 12456,
                                       trackName: "Track name",
                                       sellerName: "Seller's name",
                                       version: "1.2.3",
                                       currentVersionReleaseDate: Date(),
                                       minimumOsVersion: "13.0",
                                       averageUserRating: 4.7655,
                                       userRatingCountForCurrentVersion: 123456,
                                       storeCode: "FR")
    }
    
    static var previews: some View {
        SearchResultRow(item: SearchResultRowItem(appDetails: Constants.result))
            .sizeThatFitPreview(with: "Default")
    }
}