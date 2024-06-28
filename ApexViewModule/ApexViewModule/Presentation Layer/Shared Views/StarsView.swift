//
//  RatingView.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 08/11/2023.
//

import SwiftUI

struct StarsView: View {
    
    let rating: Double
    let maxRating: Int
    let isInverted: Bool
    
    init(rating: Double, maxRating: Int = 5, isInverted: Bool = false) {
        self.rating = rating
        self.maxRating = maxRating
        self.isInverted = isInverted
    }

    init(_ ratingString: String, maxRating: Int = 5, isInverted: Bool = false) {
        self.rating = Double(ratingString) ?? 0
        self.maxRating = maxRating
        self.isInverted = isInverted
    }

    var body: some View {
        let stars = HStack(spacing: 0) {
            ForEach(0..<maxRating, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .aspectRatio(contentMode: .fit)
            }
        }

        stars.overlay(
            GeometryReader { g in
                let width = rating / CGFloat(maxRating) * g.size.width
                let offsetX = isInverted ? (5.0 - rating) / CGFloat(maxRating) * g.size.width : 0
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: width)
                        .foregroundColor(.orange)
                        .offset(x: offsetX)
                }
            }
            .mask(stars)
        )
        .foregroundColor(.gray)
    }
}

#Preview("5 stars", traits: .sizeThatFitsLayout) {
    VStack {
        StarsView(rating: 0)
        StarsView(rating: 0.5)
        StarsView(rating: 1)
        StarsView(rating: 1.5)
        StarsView(rating: 2)
        StarsView(rating: 2.5)
        StarsView(rating: 3)
        StarsView(rating: 3.5)
        StarsView(rating: 4)
        StarsView(rating: 4.5)
        StarsView(rating: 5)
    }
}

#Preview("Inverted", traits: .sizeThatFitsLayout) {
    VStack {
        StarsView(rating: 0, isInverted: true)
        StarsView(rating: 0.5, isInverted: true)
        StarsView(rating: 1, isInverted: true)
        StarsView(rating: 1.5, isInverted: true)
        StarsView(rating: 2, isInverted: true)
        StarsView(rating: 2.5, isInverted: true)
        StarsView(rating: 3, isInverted: true)
        StarsView(rating: 3.5, isInverted: true)
        StarsView(rating: 4, isInverted: true)
        StarsView(rating: 4.5, isInverted: true)
        StarsView(rating: 5, isInverted: true)
    }
}

#Preview("variable stars", traits: .sizeThatFitsLayout) {
    VStack {
        StarsView(rating: 0.5, maxRating: 1)
        StarsView(rating: 1, maxRating: 2)
        StarsView(rating: 1.5, maxRating: 3)
        StarsView(rating: 2, maxRating: 4)
        StarsView(rating: 2.5, maxRating: 5)
        StarsView(rating: 3, maxRating: 6)
        StarsView(rating: 3.5, maxRating: 7)
        StarsView(rating: 4, maxRating: 8)
        StarsView(rating: 4.5, maxRating: 9)
        StarsView(rating: 5, maxRating: 10)
    }
}
