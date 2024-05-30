//
//  AppDetailsRow.swift
//  Apex
//
//  Created by Olivier Rigault on 07/01/2022.
//

import SwiftUI
import ApexCore

struct DetailsRow: View {

    var item: DetailsRowModel
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: item.artwork) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 64, height: 64)
            .clipShape(.rect(cornerRadius: 8))
            VStack(alignment: .leading) {
                Text(item.trackName)
                Text(item.rating)
                Text(item.version)
            }
            Spacer()
        }
    }
}

//struct AppDetailsRow_Previews: PreviewProvider {
//    
//    enum Constants {
//        static let item = DetailsRowModel(details: Details(trackId: 123, trackName: "trackName", averageUserRating: 4.69179, version: "1.2.3"))
//    }
//    
//    static var previews: some View {
//        DetailsRow(item: Constants.item)
//            .sizeThatFitPreview(with: "Default")
//    }
//}
//
#Preview(traits: .sizeThatFitsLayout) {
    DetailsRow(item: DetailsRowModel(details: Details(trackId: 123, trackName: "trackName", averageUserRating: 4.69179, version: "1.2.3")))
}
