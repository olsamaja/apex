//
//  AppStoreRow.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 25/11/2021.
//

import SwiftUI

struct AppStoreRow: View {
    
    var store: AppStore
    @Binding var selectedStore: AppStore?

    var body: some View {
        HStack {
            Text(store.name)
            Spacer()
            if store == selectedStore {
                Image(systemName: "checkmark")
                    .foregroundColor(.accentColor)
            }
        }
        .onTapGesture {
            self.selectedStore = self.store
        }
    }
}

struct AppStoreRow_Previews: PreviewProvider {

    enum Constants {
        static let store = AppStore(code: "FR", name: "France")
    }
    
    static var previews: some View {
        Group {
            AppStoreRow(store: Constants.store, selectedStore: .constant(nil))
                .sizeThatFitPreview(with: "Not selected")
            AppStoreRow(store: Constants.store, selectedStore: .constant(Constants.store))
                .sizeThatFitPreview(with: "Not Selected")
        }
    }
}
