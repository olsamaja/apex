//
//  SelectStoreScreen.swift
//  ApexStoreModule
//
//  Created by Olivier Rigault on 16/05/2024.
//

import SwiftUI
import ApexCore
import ApexCoreUI

public struct SelectStoreScreen: View {
    
    let allItems = StoreRowModel.allStores()
    @EnvironmentObject var selectedStore: SelectedStore
    @Environment(\.dismiss) var dismiss

    public init() {}
    
    public var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(allItems) { item in
                        Button(item.store.name) {
                            self.selectedStore.current = item.store
                            dismiss()
                        }
                    }
                }
            }
            .navigationBarTitle("Select Store", displayMode: .inline)
        }
    }
}

#Preview {
    SelectStoreScreen()
}
