//
//  AppSectionsRow.swift
//  Apex
//
//  Created by Olivier Rigault on 07/01/2022.
//

import SwiftUI
import ApexCoreUI

struct AppSectionRows: View {

    let sectionModel: SectionModel
    
    init(with model: SectionModel) {
        self.sectionModel = model
    }
    
    var body: some View {
        if let headerModel = sectionModel.header {
            Section(header: contentRow(headerModel)) {
                if let rowModels = sectionModel.rows {
                    contentRows(rowModels)
                }
            }
            .textCase(nil)
        } else if let rowModels = sectionModel.rows {
            contentRows(rowModels)
        }
    }
    
    private func contentRow(_ rowModel: ContentRowModel) -> some View {
        AppContentRow(model: rowModel)
    }
    
    // Trick to hide disclosure indicator for iOS 16-
    // Source: https://www.appcoda.com/hide-disclosure-indicator-swiftui-list/
    // Cons: performance as content row is rendered twice.
    
    @ViewBuilder
    private func contentRows(_ rowModels: [ContentRowModel]) -> some View {
        ForEach(rowModels) { model in
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
