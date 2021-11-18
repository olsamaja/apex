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
    
    public init() {}
    
    public var body: some View {
        List {
            ForEach(allItems) { item in
                StoreRow(item: item, selectedItem: self.$selectedItem)
            }
        }
    }
}

struct CountriesView_Previews: PreviewProvider {
    static var previews: some View {
        StoresView()
    }
}
