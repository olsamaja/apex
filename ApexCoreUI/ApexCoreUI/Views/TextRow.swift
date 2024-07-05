//
//  TextRow.swift
//  ApexCoreUI
//
//  Created by Olivier Rigault on 14/01/2022.
//

import SwiftUI

public struct TextRow: View {
    
    let title: String
    
    public init(title: String) {
        self.title = title
    }

    public var body: some View {
        HStack {
            Spacer()
                .frame(width: 16)
            Text(title)
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
            Spacer()
        }
        .listRowInsets(EdgeInsets())
    }
}

#Preview("Short title", traits: .sizeThatFitsLayout) {
    TextRow(title: "Title")
}

#Preview("Long title", traits: .sizeThatFitsLayout) {
    TextRow(title: "This is a very long title. This is a very long title. \nThis is a very long title. ")
}
