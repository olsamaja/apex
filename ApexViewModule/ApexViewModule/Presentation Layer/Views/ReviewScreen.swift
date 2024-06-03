//
//  ReviewScreen.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 08/11/2023.
//

import SwiftUI

public struct ReviewScreen: View {
    
    private let model: ReviewRowModel

    public init(model: ReviewRowModel) {
        self.model = model
    }
    
    public var body: some View {
        VStack() {
            StarsView(rating: Double(model.rating)!)
            VStack(alignment: .leading) {
                HStack {
                    Grid(alignment: .leading) {
                        GridRow() {
                            Image(systemName: "person")
                                .font(.title2)
                            Text(model.author)
                                .font(.title2)
                                .multilineTextAlignment(.leading)
                        }
                        GridRow() {
                            Text("Date:")
                            Text(model.updated)
                                .font(.callout)
                        }
                        GridRow() {
                            Text("Version:")
                            Text(model.version)
                                .font(.callout)
                        }
                    }
                    Spacer()
                }
                .padding(.vertical, 10)
                Text(model.title)
                    .multilineTextAlignment(.leading)
                    .font(.headline)
                Text(model.content)
                    .multilineTextAlignment(.leading)
                    .padding(.vertical, 3)
            }
            .padding(.vertical, 10)
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
    }
}

struct ReviewView_Previews: PreviewProvider {
    
    enum Constants {
        static let model = ReviewRowModel(review: Review(title: "Incredible super long title for this review", author: "author", rating: "3", content: "This is a wonderful app, which never ceases to amaze me! Please keep the good work. Well done!", version: "4.5.6", updated: Date()))
    }
    
    static var previews: some View {
        NavigationStack {
            ReviewScreen(model: Constants.model)
                .sizeThatFitPreview(with: "Default")
        }
    }
}
