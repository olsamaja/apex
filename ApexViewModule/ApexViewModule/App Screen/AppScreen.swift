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
        case .detailsLoaded(let details):
            Spinner()
                .onAppear() {
                    Task {
                        viewModel.send(event: .onLoadingNextReviews([details]))
                        OLLogger.info("details loaded")
                    }
                }
        case .loadingDetails, .loadingNextReviews:
            Spinner()
        case .nextReviewsLoaded(let sections):
            List {
                ForEach(sections) { section in
                    SectionRows(with: section)
                        .fixedSize(horizontal: false, vertical: true)
                        .listSectionRowSeparator(section.category)
                }
                Text("Load more reviews")
                    .onAppear() {
                        Task {
//                            viewModel.send(event: .onLoadingNextReviews(<#T##SectionRowsModel#>, <#T##SectionRowsModel#>, <#T##SectionRowsModel#>))
                            OLLogger.info("load more reviews")
                        }
                    }
            }
            .listStyle(.grouped)
            .toolbar {
                Button {
                    self.storedApps.toggleFavorite(viewModel.appSummary)
                    viewModel.appSummary.isFavorite.toggle()
                } label: {
                    Image(systemName: viewModel.appSummary.isFavorite ? "heart.fill" : "heart")
                }
            }
        }
    }
    
    private func Spinner() -> some View {
        SpinnerBuilder()
            .withStyle(.large)
            .isAnimating(true)
            .build()
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


//struct AppScreen_Previews: PreviewProvider {
//    
//    enum Constants {
//        static let dates = [Date(timeIntervalSince1970: 0), Date(timeIntervalSince1970: 523456789)]
//        static let reviews = [Review(title: "title 1", author: "author 1", rating: "3", content: "content 1", version: "1.2.3", updated: Constants.dates[0]),
//                              Review(title: "title 2", author: "author 2", rating: "5", content: "This is a long comment for a suber app I intend to use every single day from now on!", version: "1.2.3", updated: Constants.dates[1])]
//        static let details = Details(trackId: 0,
//                                     trackName: "App name",
//                                     averageUserRating: 3.5,
//                                     version: "1.2.3",
//                                     minimumOsVersion: "13.0",
//                                     description: "Some description",
//                                     sellerName: "Seller name",
//                                     fileSizeBytes: 426137600,
//                                     userRatingCount: 1234)
//        static let detailsRowsModel = [SectionRowsModel(header: ContentRowModel(.text("Second Section Header")),
//                                                       rows: [ContentRowModel(.details(DetailsRowModel(details: Constants.details)))])]
//        static let sectionRowsModel = [SectionRowsModel(rows: [ContentRowModel(.review(ReviewRowModel(review: Constants.reviews[0]))),
//                                                               ContentRowModel(.review(ReviewRowModel(review: Constants.reviews[1])))]),
//                                       SectionRowsModel(rows: [ContentRowModel(.review(ReviewRowModel(review: Constants.reviews[0]))),
//                                                               ContentRowModel(.review(ReviewRowModel(review: Constants.reviews[1])))])]
//        static let appSummary = AppSummary(trackId: 1234, trackName: "My App", sellerName: "Seller", storeCode: "Store")
//    }
//    
//    static var previews: some View {
//        Group {
//            AppScreen(viewModel: AppViewModel(appSummary: Constants.appSummary))
//                .previewDisplayName("default")
//            AppScreen(viewModel: AppViewModel(appSummary: Constants.appSummary, state: .error(DataError.parsing(description: "Unable to parse data"))))
//                .previewDisplayName("error")
//            AppScreen(viewModel: AppViewModel(appSummary: Constants.appSummary, state: .detailsLoaded(Constants.detailsRowsModel, Constants.sectionRowsModel)))
//                .previewDisplayName("loaded")
//        }
//    }
//}
