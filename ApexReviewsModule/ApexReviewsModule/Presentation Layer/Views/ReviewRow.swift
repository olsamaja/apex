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
            Text("item.rating")
                .padding()
            Spacer()
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
//
//struct ReviewRow_Previews: PreviewProvider {
//    
//    enum Constants {
//        static let review = Review(
//            title: "Title",
//            author: "author",
//            rating: "4",
//            content:
//                "Some pretty good things about this awesome app. I really love this service. Hope you are going to keep up with the good stuff.",
//            version: "1.2.3",
//            updated: Date())
//    }
//    
//    static var previews: some View {
//        ReviewRow(item: ReviewRowItem(review: Constants.review))
//            .sizeThatFitPreview(with: "Default")
//    }
//}
