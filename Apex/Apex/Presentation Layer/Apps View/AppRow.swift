//
//  AppRow.swift
//  Apex
//
//  Created by Olivier Rigault on 15/12/2021.
//

import SwiftUI
import ApexCore

struct AppRow: View {
    
    let item: AppRowItem
    
    var body: some View {
        HStack {
            Text(item.trackName + " - " + item.storeCode)
            Spacer()
        }
    }
}

struct AppRow_Previews: PreviewProvider {
    
    static var previews: some View {
        AppRow(item: AppRowItem(appSummary: AppSummary(trackId: 0, trackName: "MyApp", sellerName: "My Company", storeCode: "GB")))
    }
}
