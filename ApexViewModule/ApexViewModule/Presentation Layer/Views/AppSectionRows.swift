//
//  AppSectionsRow.swift
//  Apex
//
//  Created by Olivier Rigault on 07/01/2022.
//

import SwiftUI

struct AppSectionRows: View {

    let sectionModel: AppSectionModel
    
    init(with model: AppSectionModel) {
        self.sectionModel = model
    }
    
    var body: some View {
        if let headerModel = sectionModel.headerModel {
            Section(header: contentRow(headerModel)) {
                if let rowModels = sectionModel.rowModels {
                    contentRows(rowModels)
                }
            }
            .textCase(nil)
        } else if let rowModels = sectionModel.rowModels {
            contentRows(rowModels)
        }
    }
    
    private func contentRow(_ rowModel: AppContentRowModel) -> some View {
        AppContentRow(model: rowModel)
    }
    
    private func contentRows(_ rowModels: [AppContentRowModel]) -> some View {
        ForEach(rowModels) { model in
            contentRow(model)
        }
    }
}

//
//struct AppSectionsRow_Previews: PreviewProvider {
//    static var previews: some View {
//        AppSectionRows(sectionModel: AppSectionModel(header: <#T##AppContentRowModel?#>, rows: <#T##[AppContentRowModel]?#>))
//    }
//}
