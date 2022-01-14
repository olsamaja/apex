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
                .bold()
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
            Spacer()
        }
        .listRowInsets(EdgeInsets())
    }
}

struct TextRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TextRow(title: "Title")
                .sizeThatFitPreview(with: "Light Theme")
            TextRow(title: "Title")
                .sizeThatFitPreview(with: "Dark Theme")
                .preferredColorScheme(.dark)
        }
    }
}
