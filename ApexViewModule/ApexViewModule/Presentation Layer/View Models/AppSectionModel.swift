//
//  AppSectionModel.swift
//  Apex
//
//  Created by Olivier Rigault on 07/01/2022.
//

import SwiftUI
import ApexCoreUI

public struct AppContentRowModel: Identifiable {
    
    public var id = UUID().uuidString
    
    let type: Any
    let model: Any?
    let destination: AnyView?
    
    init(type: Any, model: Any? = nil, destination: AnyView? = nil) {
        self.type = type
        self.model = model
        self.destination = destination
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
        case reviews([Review])
    }
    
    static func makeReviewsSectionModel(with reviews: [AppReviewRowViewModel]) -> AppSectionModel {
        AppSectionModel(
            header: AppContentRowModel(type: TextRow.self, model: "Reviews (\(reviews.count))"),
            rows: reviews.map { AppContentRowModel(type: AppReviewRow.self, model: $0) })
    }
}
