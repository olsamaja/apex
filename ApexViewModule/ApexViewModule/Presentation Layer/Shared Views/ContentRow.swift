//
//  ContentRow.swift
//  Apex
//
//  Created by Olivier Rigault on 07/01/2022.
//

import SwiftUI
import ApexCoreUI

struct ContentRow: View {
    
    let model: ContentRowModel
    
    init(model: ContentRowModel) {
        self.model = model
    }

    var body: some View {
        ContentRow.makeRow(with: model)
    }
    
    static private func makeRow(with model: ContentRowModel) -> some View {
        switch model.category {
        case .text(let title):
            return AnyView( TextRow(title: title) )
        case .details(let model):
            return AnyView(
                DetailsRow(item: model)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))

            )
        case .review(let model):
            return AnyView( ReviewRow(item: model) )
        case .vitals(let model):
            return AnyView( VitalDetailsRow(item: model) )
        }
    }
}

//
//struct AppContentRow_Previews: PreviewProvider {
//    static var previews: some View {
//        AppContentRow()
//    }
//}
