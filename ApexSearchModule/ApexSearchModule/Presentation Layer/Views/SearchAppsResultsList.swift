//
//  SearchAppsResultsList.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 12/07/2021.
//
//  Issue: Text().lineLimit(n) Ignored Inside ScrollView
//  Source: https://swiftui-lab.com/bug-linelimit-ignored/
//  Description:
//    When we have a very long Text that needs more than one line to show its full contents,
//    the text will get truncated with an ellipsis, if inside a ScrollView.
//    Using .lineLimit(n) has no effect, for any value of n, including nil.
//  Solution:
//    Use .fixedSize(horizontal: false, vertical: true)

import SwiftUI
import ApexCore
import ApexCoreUI

struct SearchAppsResultsList: View {
    
    var items: [SearchResultRowModel]
    var viewModel: SearchAppsViewModel
    @State private var selectedAppStatus = SelectedAppStatus()

    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    @EnvironmentObject var storedApps: StoredApps

    @ViewBuilder
    var body: some View {
        List {
            Section {
                ChangeStoreView(viewModel: viewModel)
            } header: {
                Text("Store")
            }
            Section {
                ForEach(items) { item in
                    Button {
                        self.selectedAppStatus.toggle(with: item)
                    } label: {
                        SearchResultRow(item: item)
                            .foregroundColor(.black)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            } header: {
                Text("Apps")
            }
        }
        .confirmationDialog("", isPresented: $selectedAppStatus.showConfirmation) {
            Button("Add", action: {
                guard let item = selectedAppStatus.item else { return }
                let app = AppSummary(with: item.appDetails)
                self.storedApps.add(app)
                self.rootPresentationMode.wrappedValue.dismiss()
            })
            Button("Add as Favorite", action: {
                guard let item = selectedAppStatus.item else { return }
                let app = AppSummary(with: item.appDetails, isFavorite: true)
                self.storedApps.add(app)
                self.rootPresentationMode.wrappedValue.dismiss()
            })
        }
    }
}

public class SearchApplicationsResultsListBuilder: BuilderProtocol {
    
    private var items: [SearchResultRowModel]?
    private var viewModel = SearchAppsViewModel(state: .idle)

    public func withItems(_ items: [SearchResultRowModel]) -> SearchApplicationsResultsListBuilder {
        self.items = items
        return self
    }
        
    public func withViewModel(_ viewModel: SearchAppsViewModel) -> SearchApplicationsResultsListBuilder {
        self.viewModel = viewModel
        return self
    }

    @ViewBuilder
    public func build() -> some View {
        if let items = items, items.count > 0 {
            SearchAppsResultsList(items: items, viewModel: viewModel)
        } else {
            MessageViewBuilder()
                .withMessage("No results")
                .build()
        }
    }
}

private struct SelectedAppStatus {
    
    var showConfirmation: Bool
    var item: SearchResultRowModel?
    
    mutating func toggle(with item: SearchResultRowModel) {
        self.item = item
        showConfirmation.toggle()
    }
    
    init(showConfirmation: Bool = false, item: SearchResultRowModel? = nil) {
        self.showConfirmation = showConfirmation
        self.item = item
    }
}
