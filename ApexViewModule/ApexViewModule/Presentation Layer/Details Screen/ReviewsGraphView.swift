//
//  ReviewsGraphView.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 05/06/2024.
//

import SwiftUI
import Charts

struct ReviewsGraphView: View {
    
    var model: ReviewsGraphData

    var body: some View {
        GroupBox {
            VStack(spacing: 12) {
                HStack {
                    Text("Posts")
                        .font(.title3)
                    Spacer()
                    Text("\(model.numberOfReviews)")
                        .font(.title3)
                }
                Chart(model.items) { item in
                    BarMark(
                        x: .value("Date", 0 - item.daysSinceEndDate),
                        y: .value("Ratings", item.weight)
                    )
                    .foregroundStyle(item.ratingType.color)
                }
                .fixedSize(horizontal: false, vertical: true)
                .chartXAxis(.hidden)
                HStack {
                    Text(model.startDateShortString)
                        .font(.footnote)
                        .foregroundColor(.gray)
                    Spacer()
                    Text(model.endDateShortString)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

#Preview {
    
    enum Constants {
        static let dateFormatter = ISO8601DateFormatter()
        static let tuples = [(rating: "3", date: "2024-06-06T11:42:44-07:00"),
                             (rating: "1", date: "2024-06-05T11:42:44-07:00"),
                             (rating: "4", date: "2024-06-03T11:42:44-07:00"),
                             (rating: "3", date: "2024-06-02T11:42:44-07:00"),
                             (rating: "1", date: "2024-06-01T11:42:44-07:00"),
                             (rating: "5", date: "2024-06-05T11:42:44-07:00")]
        static let endDate = dateFormatter.date(from: tuples[0].date)!
        static let reviews = tuples.map { Review(title: "", author: "", rating: $0.rating, content: "", version: "", updated: dateFormatter.date(from: $0.date)!) }
    }
    
    return ReviewsGraphView(model: ReviewsGraphDataBuilder()
        .withEndDate(Constants.endDate)
        .withNumberOfDays(7)
        .withReviews(Constants.reviews)
        .build())
}
