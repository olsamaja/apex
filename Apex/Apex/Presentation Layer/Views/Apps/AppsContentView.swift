//
//  AppsContentView.swift
//  Apex
//
//  Created by Olivier Rigault on 14/12/2021.
//

import SwiftUI
import ApexCoreUI
import ApexCore
import ApexSearchModule

struct AppsContentView: View {
    
    @ObservedObject var viewModel: AppsViewModel
    var searchApps = ""

    public var body: some View {
        switch viewModel.state {
        case .idle:
            MessageViewBuilder()
                .withMessage("Add an application")
                .withAlignment(.top)
                .build()
                .onAppear {
                    viewModel.send(event: .onAppear)
                }
        case .loading:
            MessageViewBuilder()
                .withMessage("Loading")
                .build()
        case .loaded(let items):
            List {
                ForEach(AppsSectionModel.searchAndSort(from: items, with: searchApps)) { section in
                    AppsSection(with: section)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .toolbar {
                EditButton()
            }
        case .error:
            MessageViewBuilder()
                .withMessage("Cannot load stored apps")
                .build()
        }
    }
}
