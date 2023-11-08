//
//  AppContentRow.swift
//  Apex
//
//  Created by Olivier Rigault on 07/01/2022.
//

import SwiftUI
import ApexCoreUI

struct AppContentRow: View {
    
    let model: ContentRowModel
    
    init(model: ContentRowModel) {
        self.model = model
    }

    var body: some View {
        AppContentRow.makeRow(with: model)
    }
    
    static private func makeRow(with model: ContentRowModel) -> some View {
        switch model.category {
        case .text(let title):
            return AnyView( TextRow(title: title) )
        case .appDetails(let model):
            return AnyView( AppDetailsRow(item: model) )
        case .review(let model):
            return AnyView( AppReviewRow(item: model) )
        }
    }
}

//
//struct AppContentRow_Previews: PreviewProvider {
//    static var previews: some View {
//        AppContentRow()
//    }
//}
