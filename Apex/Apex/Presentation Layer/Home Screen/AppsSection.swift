//
//  AppsSection.swift
//  Apex
//
//  Created by Olivier Rigault on 10/11/2023.
//
// Trick to hide disclosure indicator for iOS 16-
// Source: https://www.appcoda.com/hide-disclosure-indicator-swiftui-list/
// Cons: performance as content row is rendered twice.

import SwiftUI
import ApexCore

struct AppsSection: View {
    
    let model: AppsSectionModel
    
    init(with model: AppsSectionModel) {
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
            .onDelete(perform: delete)
        }
    }
    
    func delete(at offsets: IndexSet) {
        let appsToDelete = offsets.map { model.apps[$0].appSummary }
        
        _ = appsToDelete.compactMap { app in
            DispatchQueue.main.async {
                OLLogger.info("delete \(app.trackName)")
                AppFavorites().remove(app)
            }
        }
    }
}

//struct AppsSectionRow_Previews: PreviewProvider {
//    static var previews: some View {
//        AppsSectionRows()
//    }
//}
