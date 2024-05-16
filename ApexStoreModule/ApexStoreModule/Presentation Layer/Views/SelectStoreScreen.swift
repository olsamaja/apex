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
        VStack {
            Text("Select Store")
                .padding()
            HStack {
                Text("Current Store: ")
                Text(selectedStore.current.name)
            }
            List {
                ForEach(allItems) { item in
                    Button(item.store.name) {
                        self.selectedStore.current = item.store
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    SelectStoreScreen()
}
