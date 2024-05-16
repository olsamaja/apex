//
//  StoreRow.swift
//  ApexStoreModule
//
//  Created by Olivier Rigault on 17/11/2021.
//

import SwiftUI
import ApexCore
import ApexCoreUI

struct StoreRow: View {
    
    var item: StoreRowModel
    @EnvironmentObject var selectedStore: SelectedStore

    var body: some View {
        HStack {
            Text(item.store.name)
            Spacer()
            if item.store == selectedStore.current {
                Image(systemName: "checkmark")
                    .foregroundColor(.accentColor)
            }
        }
        .onTapGesture {
            self.selectedStore.current = self.item.store
        }
    }
}
//
//struct StoreRow_Previews: PreviewProvider {
//    static var previews: some View {
//        StoreRow(item: StoreRowItem(store: Store(code: "GB", name: "United Kingdom")), selectedItem: Binding<StoreRowItem?>)
//            .sizeThatFitPreview(with: "Default")
//    }
//}
