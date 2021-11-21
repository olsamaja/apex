//
//  CountriesView.swift
//  ApexStoreModule
//
//  Created by Olivier Rigault on 17/11/2021.
//

import SwiftUI
import ApexCore
import ApexCoreUI

public struct StoresView: View {
    
    let allItems = StoreRowItem.allStores()
    @State var selectedItem: StoreRowItem? = nil
    @EnvironmentObject var selectedStore: SelectedStore

    public init() {}
    
    public var body: some View {
        VStack {
            List {
                ForEach(allItems) { item in
                    StoreRow(item: item, selectedItem: self.$selectedItem)
                }
            }
            Text(selectedStore.current.name)
        }
    }
}

struct CountriesView_Previews: PreviewProvider {
    static var previews: some View {
        StoresView()
    }
}
