//
//  AppRow.swift
//  Apex
//
//  Created by Olivier Rigault on 15/12/2021.
//

import SwiftUI
import ApexCore

struct AppRow: View {
    
    let item: AppRowModel
    
    @ViewBuilder
    var body: some View {
        if item.appSummary.isFavorite {
            HStack {
                Text(item.trackName)
                Spacer()
                Image(systemName: "star.fill")
                    .foregroundColor(.orange)
                    .font(.caption)
            }
        } else {
            HStack {
                Text(item.trackName)
                Spacer()
            }
        }
    }
}

#Preview("Default") {
    AppRow(item: AppRowModel(appSummary: AppSummary(trackId: 0, trackName: "Picasso Photo Editor", sellerName: "My Company", storeCode: "GB")))
}

#Preview("Favorite") {
    AppRow(item: AppRowModel(appSummary: AppSummary(trackId: 0, trackName: "Picasso Photo Editor", sellerName: "My Company", storeCode: "GB", isFavorite: true)))
}

#Preview("Dark") {
    AppRow(item: AppRowModel(appSummary: AppSummary(trackId: 0, trackName: "Picasso Photo Editor", sellerName: "My Company", storeCode: "GB")))
        .preferredColorScheme(.dark)
}
