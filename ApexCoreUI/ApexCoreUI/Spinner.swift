//
//  Spinner.swift
//  ApexCoreUI
//
//  Created by Olivier Rigault on 09/07/2021.
//

import SwiftUI
import ApexCore

public struct Spinner: UIViewRepresentable {
    
    let isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    let color: Color

    public init(isAnimating: Bool,
                style: UIActivityIndicatorView.Style,
                color: Color) {
        self.isAnimating = isAnimating
        self.style = style
        self.color = color
    }
    
    public func makeUIView(context: Context) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: style)
        spinner.hidesWhenStopped = true
        spinner.color = UIColor(color)
        return spinner
    }

    public func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

public class SpinnerBuilder: BuilderProtocol {
    
    private var isAnimating: Bool = true
    private var style: UIActivityIndicatorView.Style = .large
    private var color: Color = .black

    public init() {}
    
    public func withStyle(_ style: UIActivityIndicatorView.Style) -> SpinnerBuilder {
        self.style = style
        return self
    }
    
    public func withColor(_ color: Color) -> SpinnerBuilder {
        self.color = color
        return self
    }
    
    public func isAnimating(_ isAnimating: Bool) -> SpinnerBuilder {
        self.isAnimating = isAnimating
        return self
    }
    
    public func build() -> some View {
        Spinner(isAnimating: isAnimating,
                style: style, color: color)
    }
}

struct SpinnerBuilder_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            SpinnerBuilder()
                .build()
                .sizeThatFitPreview(with: "Default (large)")
            SpinnerBuilder()
                .withStyle(.large)
                .build()
                .sizeThatFitPreview(with: "Large")
            SpinnerBuilder()
                .withStyle(.medium)
                .withColor(.purple)
                .build()
                .sizeThatFitPreview(with: "Medium")
        }
    }
}
