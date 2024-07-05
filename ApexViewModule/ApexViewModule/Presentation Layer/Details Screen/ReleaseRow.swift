//
//  ReleaseRow.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 05/07/2024.
//

import SwiftUI

struct ReleaseRow: View {
    
    var item: DetailsRowModel

    var body: some View {
        VStack {
            HStack {
                Text("What's New")
                Spacer()
            }
            HStack {
                Text(item.version)
                Spacer()
                Text("releaseDate")
            }
            Text(item.details.releaseNotes)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    
    enum Constants {
        static let details = Details(trackId: 0,
                                     trackName: "App name",
                                     averageUserRating: 3.5,
                                     version: "1.2.3",
                                     minimumOsVersion: "13.0",
                                     description: "Some description",
                                     sellerName: "Seller name",
                                     fileSizeBytes: 426137600,
                                     userRatingCount: 1234,
                                     releaseNotes: "Some release notes",
                                     releaseDate: Date())
    }
    
    return ReleaseRow(item: DetailsRowModel(details: Constants.details))
}
