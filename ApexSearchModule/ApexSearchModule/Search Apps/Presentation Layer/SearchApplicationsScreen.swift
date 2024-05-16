//
//  SearchApplicationsScreen.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 10/11/2023.
//

import SwiftUI
import ApexCore
import ApexCoreUI

public struct SearchApplicationsScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: SearchApplicationsViewModel

    public init(viewModel: SearchApplicationsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationStack {
            SearchApplicationsContentViewBuilder()
                .withViewModel(viewModel)
                .build()
                .searchable(text: $viewModel.term, placement: .navigationBarDrawer(displayMode: .always))
                .navigationBarTitle("Search Applications", displayMode: .inline)
                .navigationBarItems(
                    leading:
                        Button("Cancel") {
                            dismiss()
                        }
                )
        }
    }
}

struct SearchApplicationsScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            SearchApplicationsScreen(viewModel: SearchApplicationsViewModel(state: .idle))
                .previewDisplayName("default state = .idle")
            SearchApplicationsScreen(viewModel: SearchApplicationsViewModel(state: .error(DataError.invalidRequest)))
                .previewDisplayName("default state = .error")
        }
    }
}
