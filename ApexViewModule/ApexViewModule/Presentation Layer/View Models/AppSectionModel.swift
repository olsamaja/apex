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
    
    public var id = UUID().uuidString
    public let type: Any
    
    let model: Any?
    let destination: AnyView?
    
    init(type: Any, model: Any? = nil, destination: AnyView? = nil) {
        self.type = type
        self.model = model
        self.destination = destination
    }
}

extension AppContentRowModel: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
extension AppContentRowModel: Equatable {
    public static func == (lhs: AppContentRowModel, rhs: AppContentRowModel) -> Bool {
        
//        guard lhs.type == rhs.type else { return false }
//        guard lhs.model == rhs.model else { return false }
        return true
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
            header: AppContentRowModel(type: TextRow.self, model: "App Details"),
            rows: [AppContentRowModel(type: AppDetailsRow.self, model: model)])
    }

    static func makeReviewsSectionModel(with reviews: [AppReviewRowViewModel]) -> AppSectionModel {
        AppSectionModel(
            header: AppContentRowModel(type: TextRow.self, model: "Reviews (\(reviews.count))"),
            rows: reviews.map { AppContentRowModel(type: AppReviewRow.self, model: $0) })
    }
}
