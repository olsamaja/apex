//
//  SelectedStoreView.swift
//  ApexStoreModule
//
//  Created by Olivier Rigault on 18/11/2021.
//

import SwiftUI

public struct SelectedStoreView: View {

    @EnvironmentObject var selectedStore: SelectedStore
    
    public init() {}

    public var body: some View {
        Text(selectedStore.current.name)
    }
}

struct SelectedStoreView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedStoreView()
    }
}
