//
//  AppDetailsRow.swift
//  Apex
//
//  Created by Olivier Rigault on 07/01/2022.
//

import SwiftUI
import ApexCore

struct DetailsRow: View {

    var item: DetailsRowModel
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                AsyncImage(url: item.artwork) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 80, height: 80)
                .clipShape(.rect(cornerRadius: 16))
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 4))
                VStack(alignment: .leading) {
                    Text(item.trackName)
                        .font(.title2)
                    Text(item.details.sellerName)
                        .font(.callout)
                    Text(item.version)
                        .font(.callout)
                }
                Spacer()
            }
            Divider()
            VStack {
                StarsView(rating: item.rating)
                Text(String(format: "Rating: %.1f", item.rating))
                    .font(.callout)
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    DetailsRow(item: DetailsRowModel(details: Details(trackId: 0,
                                                      trackName: "App name",
                                                      averageUserRating: 3.5,
                                                      version: "1.2.3",
                                                      minimumOsVersion: "13.0",
                                                      description: "Some description",
                                                      sellerName: "Seller name",
                                                      fileSizeBytes: 426137600,
                                                      userRatingCount: 1234)))
}
