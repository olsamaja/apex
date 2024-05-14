//
//  AppsSectionRows.swift
//  Apex
//
//  Created by Olivier Rigault on 10/11/2023.
//
// Trick to hide disclosure indicator for iOS 16-
// Source: https://www.appcoda.com/hide-disclosure-indicator-swiftui-list/
// Cons: performance as content row is rendered twice.

import SwiftUI
import ApexCore

struct AppsSectionRows: View {
    
    let model: AppsSectionRowsModel
    
    init(with model: AppsSectionRowsModel) {
        self.model = model
    }
    
    var body: some View {
        Section(header: Text(model.store.name)) {
            ForEach(model.apps) { model in
                ZStack(alignment: .leading) {
                    NavigationLink(value: model) {
                        AppRow(item: model)
                        EmptyView()
                    }
                    .opacity(0)
                    AppRow(item: model)
                }
            }
        }
    }
}

//struct AppsSectionRow_Previews: PreviewProvider {
//    static var previews: some View {
//        AppsSectionRows()
//    }
//}
