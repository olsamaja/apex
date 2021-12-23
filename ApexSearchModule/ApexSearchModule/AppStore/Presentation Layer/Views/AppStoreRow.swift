//
//  AppStoreRow.swift
//  ApexSearchModule
//
//  Created by Olivier Rigault on 25/11/2021.
//

import SwiftUI

struct AppStoreRow: View {
    
    let store: AppStore
    @Binding var selectedStore: AppStore?
    
    public init(store: AppStore, selectedStore: Binding<AppStore?>) {
        self.store = store
        self._selectedStore = selectedStore
    }

    var body: some View {
        HStack {
            Text(store.name)
            Spacer()
        }
        .onTapGesture {
            self.selectedStore = self.store
            AppStoreManager.defaultStore = store
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
                .sizeThatFitPreview(with: "Selected")
        }
    }
}
