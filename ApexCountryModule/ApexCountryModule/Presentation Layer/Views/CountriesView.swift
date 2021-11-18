//
//  CountriesView.swift
//  ApexCountryModule
//
//  Created by Olivier Rigault on 17/11/2021.
//

import SwiftUI
import ApexCore
import ApexCoreUI

public struct CountriesView: View {
    
    public init() {}
    
    public var body: some View {
        CountriesListBuilder()
            .withItems(CountryRowItem.allCountries())
            .build()
    }
}

struct CountriesView_Previews: PreviewProvider {
    static var previews: some View {
        CountriesView()
    }
}
