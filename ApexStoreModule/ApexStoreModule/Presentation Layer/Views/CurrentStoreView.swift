//
//  CurrentStoreView.swift
//  ApexStoreModule
//
//  Created by Olivier Rigault on 18/11/2021.
//

import SwiftUI

public struct CurrentStoreView: View {
    
    public init() {}

    public var body: some View {
        Text(StoreRepository.current.name)
    }
}

struct CurrentStoreView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentStoreView()
    }
}
