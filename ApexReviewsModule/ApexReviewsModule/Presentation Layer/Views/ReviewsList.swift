//
//  ReviewsList.swift
//  ApexReviewsModule
//
//  Created by Olivier Rigault on 10/07/2021.
//

import SwiftUI
import ApexCore
import ApexCoreUI

struct ReviewsList: View {
    
    var items: [ReviewRowItem]
    
    var body: some View {
        List {
            ForEach(items) { item in
                ReviewRowBuilder()
                    .withItem(item)
                    .build()
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
            MessageViewBuilder()
                .withMessage("No reviews")
                .withAlignment(.top)
                .build()
        }
    }
}
//
//struct ReviewsList_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ReviewsListBuilder()
//                .withItems([
//                    ReviewRowItem(review: Review(title: "Almost Perfect",
//                                                 author: "Author",
//                                                 rating: "4",
//                                                 content: "This is an awesome app, but I am really hesitating to give it 5 stars.",
//                                                 version: "1.2.3",
//                                                 updated: Date())),
//                    ReviewRowItem(review: Review(title: "Fantastic",
//                                                 author: "Another author",
//                                                 rating: "5",
//                                                 content: "Super useful",
//                                                 version: "3.2.1",
//                                                 updated: Date()))
//                ])
//                .build()
//            ReviewsListBuilder()
//                .build()
//        }
//    }
//}
