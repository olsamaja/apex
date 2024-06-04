//
//  DetailsScreen.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 03/06/2024.
//

import SwiftUI
import ApexCore
import ApexCoreUI

public struct DetailsScreen: View {

    private let model: DetailsViewModel

    public init(model: DetailsViewModel) {
        self.model = model
    }

    public var body: some View {
        VStack {
            Text(model.details.trackName)
            Text(String(format: "Rating: %.1f", model.details.averageUserRating))
            Text(model.details.version)
            Text(model.details.minimumOsVersion)
            Text(model.details.description)
            Text(model.details.fileSizeBytes)
            Text("\(model.details.userRatingCount)")
            Spacer()
        }
    }
}

//#Preview {
//    DetailsScreen()
//}
