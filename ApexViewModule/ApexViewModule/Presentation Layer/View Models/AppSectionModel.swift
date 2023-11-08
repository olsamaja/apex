//
//  AppSectionModel.swift
//  Apex
//
//  Created by Olivier Rigault on 07/01/2022.
//

import SwiftUI
import ApexCoreUI
import ApexCore

public struct AppContentRowModel: Identifiable {
    
    public enum Category {
        case text(String)
        case appDetails(AppDetailsRowViewModel)
        case review(AppReviewRowViewModel)
    }
    
    public var id = UUID().uuidString
    public let category: AppContentRowModel.Category
    
    init(_ category: AppContentRowModel.Category) {
        self.category = category
    }
}

extension AppContentRowModel: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension AppContentRowModel: Equatable {
    public static func == (lhs: AppContentRowModel, rhs: AppContentRowModel) -> Bool {
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

public struct AppSectionModel: Identifiable {
    
    public var id = UUID().uuidString
    
    let headerModel: AppContentRowModel?
    let rowModels: [AppContentRowModel]?
    
    init(header: AppContentRowModel? = nil, rows: [AppContentRowModel]? = nil) {
        self.headerModel = header
        self.rowModels = rows
    }
}

extension AppSectionModel {
    
    enum SectionType {
        case appDetails(AppDetails)
        case reviews([Review])
    }
    
    static func makeDetailsSectionModel(with model: AppDetailsRowViewModel) -> AppSectionModel {
        AppSectionModel(
            header: AppContentRowModel(.text("App Details")),
            rows: [AppContentRowModel(.appDetails(model))])
    }

    static func makeReviewsSectionModel(with reviews: [AppReviewRowViewModel]) -> AppSectionModel {
        AppSectionModel(
            header: AppContentRowModel(.text("Reviews (\(reviews.count))")),
            rows: reviews.map { AppContentRowModel(.review($0)) })
    }
}
