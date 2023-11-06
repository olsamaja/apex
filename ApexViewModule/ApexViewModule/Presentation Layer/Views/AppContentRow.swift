//
//  AppContentRow.swift
//  Apex
//
//  Created by Olivier Rigault on 07/01/2022.
//

import SwiftUI
import ApexCoreUI

struct AppContentRow: View {
    
    let model: AppContentRowModel
    
    init(model: AppContentRowModel) {
        self.model = model
    }

    var body: some View {
        AppContentRow.makeRow(with: model)
    }
    
    static private func makeRow(with model: AppContentRowModel) -> some View {
        switch model.type.self {
        case is TextRow.Type:
            guard let title = model.model as? String else {
                return AnyView(EmptyView())
            }
            return AnyView( TextRow(title: title) )
        case is AppReviewRow.Type:
            guard let model = model.model as? AppReviewRowViewModel else {
                return AnyView(EmptyView())
            }
            return AnyView( AppReviewRow(item: model) )
        case is AppDetailsRow.Type:
            guard let model = model.model as? AppDetailsRowViewModel else {
                return AnyView(EmptyView())
            }
            return AnyView( AppDetailsRow(item: model) )
        default: return AnyView(EmptyView())
        }
    }
}

//
//struct AppContentRow_Previews: PreviewProvider {
//    static var previews: some View {
//        AppContentRow()
//    }
//}
