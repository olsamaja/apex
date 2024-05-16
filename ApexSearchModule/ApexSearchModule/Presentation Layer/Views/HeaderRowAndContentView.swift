//
//  HeaderRowAndContentView.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 21/11/2023.
//

import SwiftUI

public struct HeaderRowAndContentView<Header: View, Content: View>: View {

    let header: Header
    var headerTitle: String?
    let content: Content?

    public init(_ title: String? = nil, @ViewBuilder header: () -> Header, content: (() -> Content)? = nil) {
        self.header = header()
        self.content = content?()
        self.headerTitle = title
    }
    
    @ViewBuilder
    public var body: some View {
        VStack {
            if let title = headerTitle {
                HStack {
                    Text(title.uppercased())
                        .font(.footnote)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                    Spacer()
                }
                .padding([.leading, .trailing], 40)
                .padding([.top], 10)
            }
            header
                .frame(width: UIScreen.main.bounds.width - 80)
                .padding([.leading, .trailing], 20)
                .padding([.top, .bottom], 12)
                .background(Color(UIColor.systemBackground))
                .cornerRadius(12)
            .frame(width: UIScreen.main.bounds.width)
            content
            Spacer()
        }
        .background(Color(UIColor.systemGroupedBackground))
    }
}

extension HeaderRowAndContentView where Content == EmptyView {
    init(_ title: String? = nil, @ViewBuilder header: () -> Header) {
        self.header = header()
        self.content = nil
        self.headerTitle = title
    }
}

struct HeaderRowAndContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            HeaderRowAndContentView("Section") {
                Text("Row")
            } content: {
                Text("Some content")
            }
            .previewDisplayName("Default")
            HeaderRowAndContentView {
                Text("Row")
            }
            .previewDisplayName("Row, no header title, no content")
            HeaderRowAndContentView("Header") {
                Text("Row")
            }
            .previewDisplayName("Row, no content")
            HeaderRowAndContentView("Section") {
                Text("Row")
            } content: {
                Text("Some content")
            }
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark theme")
        }
    }
}
