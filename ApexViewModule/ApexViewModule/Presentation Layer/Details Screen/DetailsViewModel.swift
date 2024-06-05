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
        let sections = SectionRowsModel.makeDetailsSectionModel(with: DetailsRowModel(details: details))
        let desc = SectionRowsModel(rows: [
            ContentRowModel(.vitals(DetailsRowModel(details: details))),
            ContentRowModel(.text(details.description))
        ])
        return [sections, desc]
    }
    
    public init(details: Details) {
        self.id = UUID().uuidString
        self.details = details
    }
}
