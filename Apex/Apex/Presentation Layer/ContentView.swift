//
//  ContentView.swift
//  Apex
//
//  Created by Olivier Rigault on 09/07/2021.
//

import SwiftUI
import ApexReviewsModule
import ApexSearchModule

struct ContentView: View {
    var body: some View {
        AppsView(viewModel: AppsViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
