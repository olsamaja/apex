//
//  AppDetailsRow.swift
//  Apex
//
//  Created by Olivier Rigault on 07/01/2022.
//

import SwiftUI
import ApexCore

struct AppDetailsRow: View {

    var item: AppDetailsRowViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.trackName)
            Text(item.rating)
            Text(item.version)
        }
    }
}

struct AppDetailsRow_Previews: PreviewProvider {
    
    enum Constants {
        static let item = AppDetailsRowViewModel(appDetails: AppDetails(trackId: 123, trackName: "trackName", averageUserRating: 4.69179, version: "1.2.3"))
    }
    
    static var previews: some View {
        AppDetailsRow(item: Constants.item)
            .sizeThatFitPreview(with: "Default")
    }
}
