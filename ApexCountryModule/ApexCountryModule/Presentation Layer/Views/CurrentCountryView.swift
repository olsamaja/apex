//
//  CurrentCountryView.swift
//  ApexCountryModule
//
//  Created by Olivier Rigault on 18/11/2021.
//

import SwiftUI

public struct CurrentCountryView: View {
    
    public init() {}

    public var body: some View {
        Text(CountryRepository.current.name)
    }
}

struct CurrentCountryView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentCountryView()
    }
}
