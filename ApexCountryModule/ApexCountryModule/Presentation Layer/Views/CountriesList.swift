//
//  CountriesList.swift
//  ApexCountryModule
//
//  Created by Olivier Rigault on 17/11/2021.
//

import SwiftUI
import ApexCore
import ApexCoreUI

struct CountriesList: View {

    var items: [CountryRowItem]

    var body: some View {
        List {
            ForEach(items) { item in
                CountryRow(item: item)
            }
        }
    }
}

public class CountriesListBuilder: BuilderProtocol {
    
    var items: [CountryRowItem]?

    public func withItems(_ items: [CountryRowItem]) -> CountriesListBuilder {
        self.items = items
        return self
    }
    
    @ViewBuilder
    public func build() -> some View {
        if let items = items {
            CountriesList(items: items)
        } else {
            EmptyView()
        }
    }
}

struct CountriesList_Previews: PreviewProvider {
    
    enum Constants {
        static let country1 = Country(code: "GB", name: "United Kingdom")
        static let country2 = Country(code: "FR", name: "France")
        static let country3 = Country(code: "DE", name: "Germany")
        static let items = [
            CountryRowItem(country: country1),
            CountryRowItem(country: country2),
            CountryRowItem(country: country3)
        ]
    }
    
    static var previews: some View {
        CountriesList(items: Constants.items)
    }
}
