//
//  ReviewsList.swift
//  ApexReviewsModule
//
//  Created by Olivier Rigault on 10/07/2021.
//

import SwiftUI
import ApexCore

struct ReviewsList: View {
    
    var items: [ReviewRowItem]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(items) { item in
                    ReviewRowBuilder()
                        .withItem(item)
                        .build()
                }
            }
        }
    }
}

public class ReviewsListBuilder: BuilderProtocol {
    
    var items: [ReviewRowItem]?

    public func withItems(_ items: [ReviewRowItem]) -> ReviewsListBuilder {
        self.items = items
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let items = items {
            ReviewsList(items: items)
        } else {
            EmptyView()
        }
    }
}

//struct ReviewsList_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewsListBuilder()
//            .withItems([
//                ReviewRowItem(author: "", rating: "", content: "")
//            ])
//            .build()
//    }
//}
