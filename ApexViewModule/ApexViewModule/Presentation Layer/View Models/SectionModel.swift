//
//  AppSectionModel.swift
//  Apex
//
//  Created by Olivier Rigault on 07/01/2022.
//

import SwiftUI
import ApexCoreUI
import ApexCore

public struct SectionModel: Identifiable {
    
    public var id = UUID().uuidString
    
    let header: ContentRowModel?
    let rows: [ContentRowModel]?
    
    init(header: ContentRowModel? = nil, rows: [ContentRowModel]? = nil) {
        self.header = header
        self.rows = rows
    }
}

extension SectionModel {
    
    enum Category {
        case details(Details)
        case reviews([Review])
    }
    
    static func makeDetailsSectionModel(with model: DetailsRowViewModel) -> SectionModel {
        SectionModel(
            header: ContentRowModel(.text("App Details")),
            rows: [ContentRowModel(.details(model))])
    }

    static func makeReviewsSectionModel(with reviews: [ReviewRowViewModel]) -> SectionModel {
        SectionModel(
            header: ContentRowModel(.text("Reviews (\(reviews.count))")),
            rows: reviews.map { ContentRowModel(.review($0)) })
    }
}
