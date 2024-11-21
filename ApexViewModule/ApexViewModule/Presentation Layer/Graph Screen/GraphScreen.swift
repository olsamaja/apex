//
//  GraphScreen.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 20/08/2024.
//

import SwiftUI
import ApexCore
import ApexCoreUI
import Resolver

public struct GraphScreen: View {
    
    @StateObject private var viewModel: GraphViewModel

    public init(viewModel: GraphViewModel) {
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
        case .loadingNextReviews(_, let reviews):
            MessageViewBuilder()
                .withMessage("Loading more reviews (\(reviews.count) )...")
                .withAlignment(.top)
                .build()
        case .nextReviewsLoaded(let graphs, _):
            VStack {
                Text("Reviews")
                    .font(.title)
                    .padding(.top)
                List {
                    Content(sections: graphs)
                }
                .listStyle(.grouped)
                .scrollContentBackground(.hidden)
            }
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

//#Preview {
//    GraphScreen(model: GraphViewModel())
//}
