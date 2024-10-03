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
//
//  How to do pagination in SwiftUI:
//      - https://medium.engineering/how-to-do-pagination-in-swiftui-04511be7fbd1

import SwiftUI
import ApexCore
import ApexCoreUI
import Resolver

public struct AppScreen: View {
    
    @StateObject var viewModel: AppViewModel
    @EnvironmentObject var storedApps: StoredApps
    @State var showGraph = false

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
        case .loadingDetails:
            Spinner()
        case .detailsLoaded(let details):
            Spinner()
                .onAppear() {
                    Task {
                        viewModel.send(event: .onLoadingNextReviews(details, [], []))
                        OLLogger.info("details loaded")
                    }
                }
        case .loadingNextReviews(let details, let graphs, let reviews):
            List {
                Content(sections: [details] + graphs + reviews)
                Spinner(.medium)
            }
            .listStyle(.grouped)
        case .nextReviewsLoaded(let details, let graphs, let reviews):
            List {
                Content(sections: [details] + graphs + reviews)
            }
            .listStyle(.grouped)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        self.showGraph.toggle()
                    } label: {
                        Image(systemName: "align.vertical.bottom")
                    }
                    Button {
                        self.storedApps.toggleFavorite(viewModel.appSummary)
                        viewModel.appSummary.isFavorite.toggle()
                    } label: {
                        Image(systemName: viewModel.appSummary.isFavorite ? "heart.fill" : "heart")
                    }
                }
            }
            .sheet(isPresented: $showGraph, content: {
                GraphScreen(viewModel: GraphViewModel(appSummary: viewModel.appSummary))
            })
        }
    }
    
    private func Content(sections: ([SectionRowsModel])) -> some View {
        ForEach(sections) { section in
            SectionRows(with: section)
                .fixedSize(horizontal: false, vertical: true)
                .listSectionRowSeparator(section.category)
        }
    }
    
    private func Spinner(_ style: UIActivityIndicatorView.Style = .large) -> some View {
        HStack {
            Spacer()
            SpinnerBuilder()
                .withStyle(style)
                .isAnimating(true)
                .build()
            Spacer()
        }
    }
}

struct ListSectionRowSeparator: ViewModifier {
    
    let visibility: Visibility

    public func body(content: Content) -> some View {
        content
            .listRowSeparator(visibility)
    }
}
    
extension View {
    
    public func listSectionRowSeparator(_ category: SectionRowsModel.Category? = SectionRowsModel.Category.none) -> some View {
        if let category = category, case SectionRowsModel.Category.reviews = category {
            return self.modifier(ListSectionRowSeparator(visibility: .visible))
        } else {
            return self.modifier(ListSectionRowSeparator(visibility: .hidden))
        }
    }
}

#Preview("Loaded state") {
    let dates = [Date(timeIntervalSince1970: 0), Date(timeIntervalSince1970: 523456789)]
    let reviews = [Review(title: "title 1", author: "author 1", rating: "3", content: "content 1", version: "1.2.3", updated: dates[0]),
                          Review(title: "title 2", author: "author 2", rating: "5", content: "This is a long comment for a suber app I intend to use every single day from now on!", version: "1.2.3", updated: dates[1])]
    let details = Details(trackId: 0,
                          trackName: "App name",
                          averageUserRating: 3.5,
                          version: "1.2.3",
                          minimumOsVersion: "13.0",
                          description: "Some description",
                          sellerName: "Seller name",
                          fileSizeBytes: 426137600,
                          userRatingCount: 1234,
                          releaseNotes: "This is a new release.",
                          releaseDate: dates[1])
    let detailsRowsModel = SectionRowsModel(header: ContentRowModel(.text("Second Section Header")),
                                                   rows: [ContentRowModel(.details(DetailsRowModel(details: details)))])
    let sectionRowsModel = [SectionRowsModel(rows: [ContentRowModel(.review(ReviewRowModel(review: reviews[0]))),
                                                           ContentRowModel(.review(ReviewRowModel(review: reviews[1])))]),
                                   SectionRowsModel(rows: [ContentRowModel(.review(ReviewRowModel(review: reviews[0]))),
                                                           ContentRowModel(.review(ReviewRowModel(review: reviews[1])))])]
    let appSummary = AppSummary(trackId: 1234, trackName: "My App", sellerName: "Seller", storeCode: "Store")

    AppScreen(viewModel: AppViewModel(appSummary: appSummary, state: .nextReviewsLoaded(detailsRowsModel, [], sectionRowsModel)))
}
