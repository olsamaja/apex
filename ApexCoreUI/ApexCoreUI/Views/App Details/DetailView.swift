//
//  DetailView.swift
//  ApexCoreUI
//
//  Created by Olivier Rigault on 23/11/2021.
//

import SwiftUI
import ApexCore

struct DetailView: View {
    
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.callout)
                .padding(EdgeInsets(top: 2, leading: 6, bottom: 2, trailing: 6))
                .background(Color.accentColor)
                .cornerRadius(8.0)
            Text(value)
                .font(.callout)
            Spacer()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(title: "Title", value: "value")
            .sizeThatFitPreview(with: "Example")
    }
}
