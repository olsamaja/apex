//
//  RatingView.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 08/11/2023.
//

import SwiftUI

struct RatingView: View {
    
    private let rating: Int
    
    public init(rating: Int) {
        self.rating = rating
    }
    
    @ViewBuilder
    var body: some View {
        HStack {
            ForEach (0..<5) { i in
                StarView(isFilled: i < rating)
            }
        }
    }
    
    private func StarView(isFilled: Bool) -> some View {
        Image(systemName: isFilled ? "star.fill" : "star")
            .foregroundColor(.orange)
            .font(.caption2)
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RatingView(rating: 1)
                .sizeThatFitPreview(with: "")
            RatingView(rating: 2)
                .sizeThatFitPreview(with: "")
            RatingView(rating: 3)
                .sizeThatFitPreview(with: "")
            RatingView(rating: 4)
                .sizeThatFitPreview(with: "")
            RatingView(rating: 5)
                .sizeThatFitPreview(with: "")
        }
    }
}
