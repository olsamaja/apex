//
//  AppScreen.swift
//  Apex
//
//  Created by Olivier Rigault on 04/01/2022.
//
//  @StateObject and @ObservedObject have similar characteristics but differ in how SwiftUI manages their lifecycle.
//  Use the state object property wrapper to ensure consistent results when the current view creates the observed object.
//  Whenever you inject an observed object as a dependency, you can use the @ObservedObject.
//
//  It’s unsafe to create an @ObservedObject inside a view since SwiftUI might create or recreate a view at any time.
//  Unless you inject the @ObservedObject as a dependency, you want to use the @StateObject wrapper to ensure consistent results after a view redraw.
//
//  References:
//      - https://www.avanderlee.com/swiftui/stateobject-observedobject-differences/
//
//  How to inject a @StateObject:
//      - https://stackoverflow.com/questions/64938325/how-to-initialize-a-view-with-a-stateobject-as-a-parameter

import SwiftUI
import ApexCore
import ApexCoreUI

public struct AppScreen: View {
    
    @StateObject var viewModel: AppViewModel

    public init(viewModel: AppViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        switch viewModel.state {
        case .idle:
            MessageViewBuilder()
                .withMessage("Loading reviews")
                .withAlignment(.top)
                .build()
                .onAppear {
                    viewModel.send(event: .onAppear)
                }
        case .error(let error):
            MessageViewBuilder()
                .withSymbol("xmark.octagon")
                .withMessage(error.localizedDescription)
                .build()
        case .loaded(let sections):
            List {
                ForEach(sections) { section in
                    SectionRows(with: section)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        case .loading:
            SpinnerBuilder()
                .withStyle(.large)
                .isAnimating(true)
                .build()
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppScreen(viewModel: AppViewModel(appSummary: AppSummary(trackId: 1234, trackName: "My App", sellerName: "Seller", storeCode: "Store")))
    }
}
