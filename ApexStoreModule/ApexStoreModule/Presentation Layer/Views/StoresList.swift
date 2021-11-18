//
//  CountriesList.swift
//  ApexStoreModule
//
//  Created by Olivier Rigault on 17/11/2021.
//

import SwiftUI
import ApexCore
import ApexCoreUI

struct StoresList: View {

    var items: [StoreRowItem]

    var body: some View {
        List {
            ForEach(items) { item in
                StoreRow(item: item)
            }
        }
    }
}

public class CountriesListBuilder: BuilderProtocol {
    
    var items: [StoreRowItem]?

    public func withItems(_ items: [StoreRowItem]) -> CountriesListBuilder {
        self.items = items
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let items = items {
            StoresList(items: items)
        } else {
            EmptyView()
        }
    }
}

struct CountriesList_Previews: PreviewProvider {
    
    enum Constants {
        static let store1 = Store(code: "GB", name: "United Kingdom")
        static let store2 = Store(code: "FR", name: "France")
        static let store3 = Store(code: "DE", name: "Germany")
        static let items = [
            StoreRowItem(store: store1),
            StoreRowItem(store: store2),
            StoreRowItem(store: store3)
        ]
    }
    
    static var previews: some View {
        StoresList(items: Constants.items)
    }
}
