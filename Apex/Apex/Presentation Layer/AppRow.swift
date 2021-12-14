//
//  AppRow.swift
//  Apex
//
//  Created by Olivier Rigault on 15/12/2021.
//

import SwiftUI

struct AppRow: View {
    
    let item: AppRowItem
    
    var body: some View {
        HStack {
            Text(item.trackName + " - " + item.storeCode)
            Spacer()
        }
    }
}
//
//struct AppRow_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        AppRow()
//    }
//}
