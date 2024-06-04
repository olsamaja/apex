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
import Resolver

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
                .withMessage(error.description)
                .build()
        case .loaded(let sections):
            List {
                ForEach(sections) { section in
                    SectionRows(with: section)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .listStyle(.grouped)
        case .loading:
            SpinnerBuilder()
                .withStyle(.large)
                .isAnimating(true)
                .build()
        }
    }
}

struct AppScreen_Previews: PreviewProvider {
    
    enum Constants {
        static let dates = [Date(timeIntervalSince1970: 0), Date(timeIntervalSince1970: 523456789)]
        static let reviews = [Review(title: "title 1", author: "author 1", rating: "3", content: "content 1", version: "1.2.3", updated: Constants.dates[0]),
                              Review(title: "title 2", author: "author 2", rating: "5", content: "This is a long comment for a suber app I intend to use every single day from now on!", version: "1.2.3", updated: Constants.dates[1])]
        static let details = Details(trackId: 0,
                                     trackName: "App name",
                                     averageUserRating: 3.5,
                                     version: "1.2.3",
                                     minimumOsVersion: "13.0",
                                     description: "Some description",
                                     sellerName: "Seller name",
                                     fileSizeBytes: "426137600",
                                     userRatingCount: 1234)
        static let sectionRowsModel = [SectionRowsModel(header: ContentRowModel(.text("First Section Header")),
                                                        rows: [ContentRowModel(.text("some text")),
                                                               ContentRowModel(.text("some other text"))]),
                                       SectionRowsModel(header: ContentRowModel(.text("Second Section Header")),
                                                        rows: [ContentRowModel(.details(DetailsRowModel(details: Constants.details)))]),
                                       SectionRowsModel(rows: [ContentRowModel(.review(ReviewRowModel(review: Constants.reviews[0]))),
                                                               ContentRowModel(.review(ReviewRowModel(review: Constants.reviews[1])))])]
        static let appSummary = AppSummary(trackId: 1234, trackName: "My App", sellerName: "Seller", storeCode: "Store")
    }
    
    static var previews: some View {
        Group {
            AppScreen(viewModel: AppViewModel(appSummary: Constants.appSummary))
                .previewDisplayName("default")
            AppScreen(viewModel: AppViewModel(appSummary: Constants.appSummary, state: .error(DataError.parsing(description: "Unable to parse data"))))
                .previewDisplayName("error")
            AppScreen(viewModel: AppViewModel(appSummary: Constants.appSummary, state: .loaded(Constants.sectionRowsModel)))
                .previewDisplayName("loaded")
        }
    }
}
