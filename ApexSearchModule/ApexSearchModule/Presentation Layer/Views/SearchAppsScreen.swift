//
//  SearchAppsScreen.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 10/11/2023.
//

import SwiftUI
import ApexCore
import ApexCoreUI

public struct SearchAppsScreen: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: SearchAppsViewModel

    public init(viewModel: SearchAppsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationStack {
            SearchApplicationsContentViewBuilder()
                .withViewModel(viewModel)
                .build()
                .searchable(text: $viewModel.term, placement: .navigationBarDrawer(displayMode: .always))
                .autocorrectionDisabled(true)
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
            SearchAppsScreen(viewModel: SearchAppsViewModel(state: .idle))
                .previewDisplayName("default state = .idle")
            SearchAppsScreen(viewModel: SearchAppsViewModel(state: .error(DataError.invalidRequest)))
                .previewDisplayName("default state = .error")
        }
    }
}
