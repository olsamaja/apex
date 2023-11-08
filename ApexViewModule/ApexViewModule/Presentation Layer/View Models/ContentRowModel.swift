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
    
    public enum Category {
        case text(String)
        case appDetails(DetailsRowViewModel)
        case review(ReviewRowViewModel)
    }
    
    public var id = UUID().uuidString
    public let category: ContentRowModel.Category
    
    init(_ category: ContentRowModel.Category) {
        self.category = category
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
        case (.appDetails(let lhsDetails), .appDetails(let rhsDetails)):
            return lhsDetails.id == rhsDetails.id
        case (.review(let lhsReview), .review(let rhsReview)):
            return lhsReview.id == rhsReview.id
        default:
            return false
        }
    }
}
