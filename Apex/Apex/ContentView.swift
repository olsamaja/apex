//
//  ContentView.swift
//  Apex
//
//  Created by Olivier Rigault on 09/07/2021.
//

import SwiftUI
import ApexReviewsModule

struct ContentView: View {
    var body: some View {
        ReviewsView(viewModel: ReviewsViewModel(appId: "436115342"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
