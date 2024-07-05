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
        VStack(spacing: 8) {
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
                        .font(.title3)
                    Text(item.details.sellerName)
                        .font(.subheadline)
                    Spacer()
                }
                Spacer()
            }
            Divider()
            VStack(spacing: 6) {
                StarsView(rating: item.rating)
                Text(String(format: "Rating: %.1f", item.rating))
                    .font(.subheadline)
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
                                                      userRatingCount: 1234,
                                                      releaseNotes: "Some release notes",
                                                      releaseDate: Date())))
}
