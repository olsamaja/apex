//
//  AppsContentView.swift
//  Apex
//
//  Created by Olivier Rigault on 14/12/2021.
//

import SwiftUI
import ApexCoreUI
import ApexCore

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
                ForEach(searchAndSort(from: items, with: searchApps)) { section in
                    AppsSectionRows(with: section)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            
//            List {
//                ForEach(searchAndSort(from: items, with: searchApps)) { section in
//                    StoreHeaderRow()
//                    ForEach(section.rows) { item in
//                        NavigationLink(value: item) {
//                            AppRow(item: item)
//                        }
//                    }
//                }
//            }
            
//            List {
//                ForEach(searchResults(from: items, with: searchApps)) { item in
//                    NavigationLink(value: item) {
//                        AppRow(item: item)
//                    }
//                }
//            }
        case .error:
            MessageViewBuilder()
                .withMessage("Cannot load favorites")
                .build()
        }
    }
    
    private func searchResults(from items: [AppRowModel], with term: String) -> [AppRowModel] {
        if term.isEmpty {
            return items
        } else {
            return items.filter { $0.trackName.contains(term) || $0.storeCode.contains(term) }
        }
    }
    
    private func searchAndSort(from items: [AppRowModel], with term: String) -> [AppsSectionRowsModel] {
        
        AppsSectionRowsModel.makeSortedAppsSectionRowsModel(with: items)
        
    }

}

public class AppsContentViewBuilder: BuilderProtocol {
    
    private var viewModel: AppsViewModel?
    
    public func withViewModel(_ viewModel: AppsViewModel) -> AppsContentViewBuilder {
        self.viewModel = viewModel
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let viewModel = viewModel {
            AppsContentView(viewModel: viewModel)
        } else {
            EmptyView()
        }
    }
}
