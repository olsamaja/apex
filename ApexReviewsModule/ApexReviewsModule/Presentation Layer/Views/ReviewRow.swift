//
//  ReviewRow.swift
//  ApexReviewsModule
//
//  Created by Olivier Rigault on 10/07/2021.
//

import SwiftUI
import ApexCore

struct ReviewRow: View {
    
    var item: ReviewRowItem
    
    var body: some View {
        VStack {
            Text(item.rating)
                .padding()
            HStack {
                VStack(alignment: .leading) {
                    Text(item.title)
                        .multilineTextAlignment(.leading)
                        .font(.title2)
                    Text(item.content)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 3)
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
                    HStack {
                        Spacer()
                        Text(item.updated)
                            .font(.footnote)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            Divider()
        }
    }
}

public class ReviewRowBuilder: BuilderProtocol {
    
    private var item: ReviewRowItem?

    public func withItem(_ item: ReviewRowItem) -> ReviewRowBuilder {
        self.item = item
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let item = item {
            ReviewRow(item: item)
        } else {
            EmptyView()
        }
    }
}

struct ReviewRow_Previews: PreviewProvider {
    static var previews: some View {
        ReviewRow(item: ReviewRowItem(
                    title: "Title",
                    author: "author",
                    rating: "4",
                    content:
                        "Some pretty good things about this awesome app. I really love this service. Hope you are going to keep up with the good stuff.",
                    version: "1.2.3",
                    updated: "2021-06-29T09:16:12-07:00"))
    }
}
