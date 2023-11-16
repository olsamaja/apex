//
//  SearchApplicationsView.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 10/11/2023.
//

import SwiftUI
import ApexCore
import ApexCoreUI

public struct SearchApplicationsView: View {
    
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
                .navigationBarTitle("Select Apps", displayMode: .inline)
                .navigationBarItems(
                    leading:
                        Button("Cancel") {
                            dismiss()
                        }
                )
        }
    }
}

struct SearchApplicationsView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            SearchApplicationsView(viewModel: SearchApplicationsViewModel(state: .idle))
                .previewDisplayName("default state = .idle")
            SearchApplicationsView(viewModel: SearchApplicationsViewModel(state: .error(DataError.invalidRequest)))
                .previewDisplayName("default state = .error")
        }
    }
}
