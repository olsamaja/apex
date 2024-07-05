//
//  DetailsViewModel.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 03/06/2024.
//

import Foundation

public struct DetailsViewModel: Identifiable {
    
    public let id: String
    public let details: Details
    
    var sections: [SectionRowsModel] {
        let detailsRowModel = DetailsRowModel(details: details)
        let sections = SectionRowsModel.makeDetailsSectionModel(with: detailsRowModel)
        let desc = SectionRowsModel(rows: [
            ContentRowModel(.vitals(detailsRowModel)),
            ContentRowModel(.release(detailsRowModel)),
            ContentRowModel(.description(detailsRowModel))
        ])
        return [sections, desc]
    }
    
    public init(details: Details) {
        self.id = UUID().uuidString
        self.details = details
    }
}
