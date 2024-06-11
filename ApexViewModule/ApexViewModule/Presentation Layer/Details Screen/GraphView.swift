//
//  GraphView.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 05/06/2024.
//

import SwiftUI
import Charts

struct GraphView: View {
    
    var item: GraphViewModel

    var body: some View {
        Chart(item.reviewData) { review in
            BarMark(
                x: .value("Date", review.dateOfDay),
                y: .value("Rating", review.ratings)
            )
            .foregroundStyle(review.ratingType.color)
        }
        .padding()
        .frame(height: 100)
    }
}

#Preview {
    
    enum Constants {
        static let dateFormatter = ISO8601DateFormatter()
        static let tuples = [(rating: "1", date: "2024-06-05T11:42:44-07:00", author: "Mon"),
                             (rating: "5", date: "2024-06-05T11:42:44-07:00", author: "Mon"),
                             (rating: "4", date: "2024-06-03T11:42:44-07:00", author: "Tue"),
                             (rating: "3", date: "2024-06-02T11:42:44-07:00", author: "Wed"),
                             (rating: "1", date: "2024-06-01T11:42:44-07:00", author: "Fri"),
                             (rating: "5", date: "2024-06-05T11:42:44-07:00", author: "Fri")]
        static let reviews = tuples.map { Review(title: "", author: $0.author, rating: $0.rating, content: "", version: "", updated: dateFormatter.date(from: $0.date) ?? Date()) }
    }
    
    return GraphView(item: GraphViewModel(reviews: Constants.reviews, numberOfDays: 7))
}
