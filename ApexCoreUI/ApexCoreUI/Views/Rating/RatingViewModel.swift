//
//  RatingViewModel.swift
//  ApexCoreUI
//
//  Created by Olivier Rigault on 13/09/2021.
//

import Foundation

public struct RatingViewModel {
    
    let rating: Double
    
    func formattedRating() -> String {
        String(format: "%.1f", rating)
    }
    
}
