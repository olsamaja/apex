//
//  AppReviewRow.swift
//  Apex
//
//  Created by Olivier Rigault on 07/01/2022.
//

import SwiftUI

public struct AppReviewRow: View {
    
    var item: AppReviewRowViewModel
    
    public var body: some View {
        VStack {
            Text(item.rating)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            HStack {
                VStack(alignment: .leading) {
                    Text(item.title)
                        .multilineTextAlignment(.leading)
                        .font(.title2)
                    Text(item.content)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, 3)
                    HStack {
                        Image(systemName: "person")
                            .font(.callout)
                        Text(item.author)
                            .font(.callout)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Text(item.version)
                            .font(.callout)
                    }
                    HStack {
                        Spacer()
                        Text(item.updated)
                            .font(.footnote)
                    }
                }
            }
        }
    }
}

struct AppReviewRow_Previews: PreviewProvider {
    
    enum Constants {
        static let item = AppReviewRowViewModel(review: Review(title: "Title", author: "author", rating: "3", content: "This is a wonderful app, which never ceases to amaze me! Please keep the good work. Well done!", version: "1.2.3", updated: Date()))
    }
    
    static var previews: some View {
            AppReviewRow(item: Constants.item)
            .sizeThatFitPreview(with: "Default")
    }
}
