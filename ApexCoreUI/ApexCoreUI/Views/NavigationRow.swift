//
//  NavigationRow.swift
//  ApexCoreUI
//
//  Created by Olivier Rigault on 22/11/2021.
//
//  References:
//  * Show list item with no disclosure indicator
//    https://thinkdiff.net/swiftui-navigationlink-hide-arrow-indicator-on-list-b842bcb78c79

import Foundation
import SwiftUI


public struct NavigationRow<Destination: View, Label: View>: View {
    
    @ViewBuilder public var destination: () -> Destination
    @ViewBuilder public var label: () -> Label
    
    public init(destination: @escaping () -> Destination, label: @escaping () -> Label) {
        self.destination = destination
        self.label = label
    }

    public var body: some View {
        ZStack {
            NavigationLink(destination: destination()) {
                EmptyView()
            }
            .opacity(0.0)
            .buttonStyle(PlainButtonStyle())

            HStack {
                label()
            }
        }
    }
}

struct NavigationRow_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationRow(destination: {
            Text("Destination")
        }, label: {
            Text("Navigation link without disclosure indicator")
        })
        .sizeThatFitPreview(with: "Navigation link w/o indicator")
    }
}
