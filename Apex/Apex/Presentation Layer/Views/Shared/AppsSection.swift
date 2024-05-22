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
import ApexStoreModule

struct AppsSection: View {
    
    let model: AppsSectionModel
    
    init(with model: AppsSectionModel) {
        self.model = model
    }
    
    var body: some View {
        Section(header: sectionHeader(with: model.store)) {
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

    func sectionHeader(with store: Store) -> some View {
        HStack {
            Text(store.name)
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "plus.circle")
            }
        }
    }

    func delete(at offsets: IndexSet) {
        let appsToDelete = offsets.map { model.apps[$0].appSummary }
        
        _ = appsToDelete.compactMap { app in
            DispatchQueue.main.async {
                OLLogger.info("delete \(app.trackName)")
                StoredApps().remove(app)
            }
        }
    }
}

#Preview("Default") {
    AppsSection(with: AppsSectionModel(store: Store(code: "FR", name: "United Kingdom"),
                                       apps: [AppRowModel(appSummary: AppSummary(trackId: 0, trackName: "Matisse Photo Editor", sellerName: "My Company", storeCode: "GB")),
                                              AppRowModel(appSummary: AppSummary(trackId: 0, trackName: "Picasso Photo Editor", sellerName: "My Company", storeCode: "GB", isFavorite: true))]))
}

