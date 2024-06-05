//
//  VitalDetailsRow.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 04/06/2024.
//

import SwiftUI

struct VitalDetailsRow: View {

    var item: DetailsRowModel

    var body: some View {
        HStack(alignment: .center) {
            VitalDetailView("Minimum") {
                Text("iOS " + item.details.minimumOsVersion + "+")
                    .vitalDetailsText()
            }
            .frame(maxWidth: .infinity)
            VitalDetailView("Ratings") {
                Text(item.details.userRatingCount.formatted())
                    .vitalDetailsText()
            }
            .frame(maxWidth: .infinity)
            VitalDetailView("Size") {
                Text(item.details.fileSizeBytes.toMBString)
                    .vitalDetailsText()
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct VitalDetailView<Content: View>: View {
    
    let title: String
    let content: Content?

    public init(_ title: String, content: (() -> Content)? = nil) {
        self.title = title
        self.content = content?()
    }
    
    public var body: some View {
        VStack {
            Text(title)
                .vitalDetailsText()
            content
        }
    }
}

struct VitalDetailsText: ViewModifier {

    public func body(content: Content) -> some View {
        content
            .font(.callout)
            .foregroundColor(.gray)
    }
}
    
extension View {
    public func vitalDetailsText() -> some View {
        self.modifier(VitalDetailsText())
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    VitalDetailsRow(item: DetailsRowModel(details: Details(trackId: 0,
                                          trackName: "App name",
                                          averageUserRating: 3.5,
                                          version: "1.2.3",
                                          minimumOsVersion: "13.0",
                                          description: "Some description",
                                          sellerName: "Seller name",
                                          fileSizeBytes: 426137600,
                                          userRatingCount: 1234)))
}
