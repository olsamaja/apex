//
//  SizeThatFitPreview.swift
//  ApexCoreUI
//
//  Created by Olivier Rigault on 09/07/2021.
//

import SwiftUI

public struct SizeThatFitPreview: ViewModifier {

    let title: String
    
    public func body(content: Content) -> some View {
        content
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .previewDisplayName(title)
    }
}
    
extension View {
    public func sizeThatFitPreview(with title: String) -> some View {
        self.modifier(SizeThatFitPreview(title: title))
    }
}
