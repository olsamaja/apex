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
    
    public init() {}
    
    public var body: some View {
        CountriesListBuilder()
            .withItems(StoreRowItem.allStores())
            .build()
    }
}

struct CountriesView_Previews: PreviewProvider {
    static var previews: some View {
        StoresView()
    }
}
