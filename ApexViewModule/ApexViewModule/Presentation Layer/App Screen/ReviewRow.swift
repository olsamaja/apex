//
//  ReviewRow.swift
//  Apex
//
//  Created by Olivier Rigault on 07/01/2022.
//

import SwiftUI

public struct ReviewRow: View {
    
    var item: ReviewRowModel
    private let lineLimitForTitle: Int?
    private let lineLimitForContent: Int?

    public init(item: ReviewRowModel, isExpanded: Bool = false) {
        self.item = item
        self.lineLimitForTitle = isExpanded ? nil : 1
        self.lineLimitForContent = isExpanded ? nil : 2
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            StarsView(item.rating)
                .padding(.vertical, 3)
            Text(item.title)
                .multilineTextAlignment(.leading)
                .font(.headline)
                .lineLimit(lineLimitForTitle)
            Text(item.content)
                .multilineTextAlignment(.leading)
                .padding(.vertical, 3)
                .lineLimit(lineLimitForContent)
            HStack {
                Image(systemName: "person")
                    .font(.callout)
                Text(item.author)
                    .font(.callout)
                    .multilineTextAlignment(.leading)
                Spacer()
                Text(item.version)
                    .font(.callout)
            }
            .padding(.vertical, 2)
            Text(item.updated)
                .font(.footnote)
        }
    }
}

#Preview {
    
    let item = ReviewRowModel(review: Review(title: "Incredible super long title for this review", author: "author", rating: "3", content: "This is a wonderful app, which never ceases to amaze me! Please keep the good work. Well done!", version: "4.5.6", updated: Date()))
    
    List {
        ReviewRow(item: item)
            .sizeThatFitPreview(with: "Default")
            .listRowSeparator(.hidden)
        ReviewRow(item: item, isExpanded: true)
            .sizeThatFitPreview(with: "Expanded review")
    }
}
