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
    
    var item: StoreRowItem
    
    var body: some View {
        HStack {
            Text(item.store.name)
            Spacer()
        }
    }
}

struct StoreRow_Previews: PreviewProvider {
    static var previews: some View {
        StoreRow(item: StoreRowItem(store: Store(code: "GB", name: "United Kingdom")))
            .sizeThatFitPreview(with: "Default")
    }
}
