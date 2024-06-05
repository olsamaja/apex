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
        List {
            ForEach(model.sections) { section in
                SectionRows(with: section)
                    .fixedSize(horizontal: false, vertical: true)
                    .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
    }
}

//#Preview {
//    DetailsScreen()
//}
