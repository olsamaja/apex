//
//  CountryRow.swift
//  ApexCountryModule
//
//  Created by Olivier Rigault on 17/11/2021.
//

import SwiftUI
import ApexCore
import ApexCoreUI

struct CountryRow: View {
    
    var item: CountryRowItem
    
    var body: some View {
        HStack {
            Text(item.country.name)
            Spacer()
        }
    }
}

struct CountryRow_Previews: PreviewProvider {
    static var previews: some View {
        CountryRow(item: CountryRowItem(country: Country(code: "GB", name: "United Kingdom")))
            .sizeThatFitPreview(with: "Default")
    }
}
