//
//  RatingView.swift
//  ApexCoreUI
//
//  Created by Olivier Rigault on 13/09/2021.
//

import SwiftUI
import ApexCore

struct RatingView: View {
    
    let viewModel: RatingViewModel
    
    var body: some View {
        Text(String(viewModel.formattedRating()))
    }
}

public class RatingViewBuilder: BuilderProtocol {
    
    private var rating: Double?
    
    public init() {}
    
    public func withRating(_ rating: Double) -> RatingViewBuilder {
        self.rating = rating
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let rating = rating {
            RatingView(viewModel: RatingViewModel(rating: rating))
        } else {
            Text("N/A")
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RatingViewBuilder()
                .build()
                .sizeThatFitPreview(with: "No rating")
            RatingViewBuilder()
                .withRating(0)
                .build()
                .sizeThatFitPreview(with: "Rating = 0")
            RatingViewBuilder()
                .withRating(1.25)
                .build()
                .sizeThatFitPreview(with: "Rating = 1.25")
            RatingViewBuilder()
                .withRating(4.7655)
                .build()
                .sizeThatFitPreview(with: "Rating = 4.7655")
        }
    }
}
