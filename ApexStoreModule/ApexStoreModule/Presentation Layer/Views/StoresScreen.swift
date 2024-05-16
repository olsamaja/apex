//
//  StoresScreen.swift
//  ApexStoreModule
//
//  Created by Olivier Rigault on 17/11/2021.
//

import SwiftUI
import ApexCore
import ApexCoreUI

public struct StoresScreen: View {
    
    let allItems = StoreRowModel.allStores()
    @EnvironmentObject var selectedStore: SelectedStore

    public init() {}
    
    public var body: some View {
        VStack {
            List {
                ForEach(allItems) { item in
                    StoreRow(item: item)
                }
            }
            Text(selectedStore.current.name)
        }
    }
}

struct CountriesView_Previews: PreviewProvider {
    static var previews: some View {
        StoresScreen()
    }
}
