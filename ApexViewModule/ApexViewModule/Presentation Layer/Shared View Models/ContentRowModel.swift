//
//  ContentRowModel.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 08/11/2023.
//

import SwiftUI
import ApexCoreUI
import ApexCore

public struct ContentRowModel: Identifiable {
    
    public enum Category: Equatable {
        case text(String)
        case details(DetailsRowModel)
        case vitals(DetailsRowModel)
        case release(DetailsRowModel)
        case graph([Review])
        case stars([Review])
        case review(ReviewRowModel)
    }
    
    public var id = UUID().uuidString
    public let category: ContentRowModel.Category
    public let isTappable: Bool
    
    init(_ category: ContentRowModel.Category, isTappable: Bool = false) {
        self.category = category
        self.isTappable = isTappable
    }
}

extension ContentRowModel: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension ContentRowModel: Equatable {
    public static func == (lhs: ContentRowModel, rhs: ContentRowModel) -> Bool {
        switch (lhs.category, rhs.category) {
        case (.text(let lhsText), .text(let rhsText)):
            return lhsText == rhsText
        case (.details(let lhsDetails), .details(let rhsDetails)), (.release(let lhsDetails), .release(let rhsDetails)), (.vitals(let lhsDetails), .vitals(let rhsDetails)):
            return lhsDetails.details == rhsDetails.details
        case (.graph(let lhsReview), .graph(let rhsReview)):
            return lhsReview.count == rhsReview.count
        case (.stars(let lhsReview), .stars(let rhsReview)):
            return lhsReview.count == rhsReview.count
        case (.review(let lhsReview), .review(let rhsReview)):
            return lhsReview.id == rhsReview.id
        default:
            return false
        }
    }
}
