//
//  DescriptionRow.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 05/07/2024.
//

import SwiftUI

struct DescriptionRow: View {
    
    var item: DetailsRowModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("About this App")
                Spacer()
            }
            .font(.title2)
            Text(item.details.description)
                .padding([.top, .bottom], 8)
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
                                     description: "Some bug fixes and minor improvements, but important enough to be released and provide a better user experience.",
                                     sellerName: "Seller name",
                                     fileSizeBytes: 426137600,
                                     userRatingCount: 1234,
                                     releaseNotes: "Some release notes.",
                                     releaseDate: Date())
    }
    
    return DescriptionRow(item: DetailsRowModel(details: Constants.details))
}
