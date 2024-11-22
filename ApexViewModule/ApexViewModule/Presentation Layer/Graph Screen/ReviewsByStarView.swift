//
//  ReviewsByStarView.swift
//  ApexViewModule
//
//  Created by Olivier Rigault on 28/06/2024.
//

import SwiftUI
import Charts

struct ReviewsByStarView: View {

    var model: ReviewsByStarData

    @ViewBuilder
    var body: some View {
        if model.numberOfReviews > 0 {
            GroupBox {
                VStack(spacing: 12) {
                    HStack {
                        Text("Stars")
                            .font(.title3)
                        Spacer()
                    }
                    HStack {
                        VStack {
                            Text(model.averageRating)
                                .font(.title2)
                            Text("out of 5")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        Chart(model.items) { item in
                            BarMark(
                                x: .value("Amount", item.numberOfReviews),
                                y: .value("Stars", item.rating)
                            )
                            .foregroundStyle(.orange)
                            .cornerRadius(8)
                            .annotation(position: .leading) {
                                StarsView(item.rating, isInverted: true)
                                    .font(.system(size: 10, weight: .semibold))
                                    .foregroundColor(.gray)
                            }
                        }
                        .fixedSize(horizontal: false, vertical: true)
                        .chartXAxis(.hidden)
                        .chartYAxis(.hidden)
                    }
                }
            }
        } else {
            EmptyView()
        }
    }
}

#Preview("Some reviews") {
    
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
    
    return ReviewsByStarView(model: ReviewsByStarGraphDataBuilder()
        .withEndDate(Constants.endDate)
        .withNumberOfDays(7)
        .withReviews(Constants.reviews)
        .build())
}

#Preview("No reviews") {
    return ReviewsByStarView(model: ReviewsByStarGraphDataBuilder()
        .build())
}
