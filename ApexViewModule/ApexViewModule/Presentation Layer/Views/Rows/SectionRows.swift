//
//  SectionsRow.swift
//  Apex
//
//  Created by Olivier Rigault on 07/01/2022.
//

import SwiftUI
import ApexCoreUI

struct SectionRows: View {

    let model: SectionRowsModel
    
    init(with model: SectionRowsModel) {
        self.model = model
    }
    
    var body: some View {
        if let header = model.header {
            Section(header: contentRow(header)) {
                if let rows = model.rows {
                    contentRows(rows)
                }
            }
            .textCase(nil)
        } else if let rows = model.rows {
            contentRows(rows)
        }
    }
    
    private func contentRow(_ model: ContentRowModel) -> some View {
        ContentRow(model: model)
    }
    
    // Trick to hide disclosure indicator for iOS 16-
    // Source: https://www.appcoda.com/hide-disclosure-indicator-swiftui-list/
    // Cons: performance as content row is rendered twice.
    
    @ViewBuilder
    private func contentRows(_ rows: [ContentRowModel]) -> some View {
        ForEach(rows) { model in
            if case .review = model.category {
                ZStack(alignment: .leading) {
                    NavigationLink(value: model) {
                        contentRow(model)
                        EmptyView()
                    }
                    .opacity(0)
                    contentRow(model)
                }
            } else {
                contentRow(model)
            }
        }
    }
}

//
//struct AppSectionsRow_Previews: PreviewProvider {
//    static var previews: some View {
//        AppSectionRows(sectionModel: AppSectionModel(header: <#T##AppContentRowModel?#>, rows: <#T##[AppContentRowModel]?#>))
//    }
//}
