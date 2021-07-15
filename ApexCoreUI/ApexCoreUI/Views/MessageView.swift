//
//  MessageView.swift
//  ApexCoreUI
//
//  Created by Olivier Rigault on 09/07/2021.
//

import SwiftUI
import ApexCore

struct MessageView: View {
    
    let symbol: String?
    let symbolSize: CGFloat?
    let message: String?
    let font: Font?
    let alignment: VerticalAlignment
    
    var body: some View {
        VStack {
            if case .bottom = alignment {
                Spacer()
            }
            if let symbol = symbol,
               let symbolSize = symbolSize {
                Image(systemName: symbol)
                    .font(.system(size: symbolSize))
                    .padding()
            }
            if let message = message,
               let font = font {
                Text(message)
                    .multilineTextAlignment(.center)
                    .font(font)
            }
            if case .top = alignment {
                Spacer()
            }
        }
        .padding()
    }
}

public class MessageViewBuilder: BuilderProtocol {
    
    private var symbol: String?
    private var symbolSize: CGFloat = 56
    private var message: String?
    private var font = Font.body
    private var alignment = VerticalAlignment.center
    
    public init() {}
    
    public func withSymbol(_ symbol: String) -> MessageViewBuilder {
        self.symbol = symbol
        return self
    }
    
    public func withSymbolSize(_ symbolSize: CGFloat) -> MessageViewBuilder {
        self.symbolSize = symbolSize
        return self
    }

    public func withMessage(_ message: String) -> MessageViewBuilder {
        self.message = message
        return self
    }
    
    public func withFont(_ font: Font) -> MessageViewBuilder {
        self.font = font
        return self
    }
    
    public func withAlignment(_ alignment: VerticalAlignment) -> MessageViewBuilder {
        self.alignment = alignment
        return self
    }
    
    public func build() -> some View {
        MessageView(symbol: symbol, symbolSize: symbolSize, message: message, font: font, alignment: alignment)
    }
}

struct MessageViewBuilder_Previews: PreviewProvider {
    
    enum Constants {
        static let symbol = "xmark.octagon"
        static let message = """
        This is a pointless, useless and very
        long explanatioon for an error,
        that we just use for testing this view
        """
    }
    
    static var previews: some View {
        Group {
            MessageViewBuilder()
                .withSymbol(Constants.symbol)
                .withSymbolSize(80)
                .withMessage(Constants.message)
                .withFont(.headline)
                .build()
                .previewDisplayName("Full error view")
            MessageViewBuilder()
                .withSymbol(Constants.symbol)
                .build()
                .previewDisplayName("Symbol only")
            MessageViewBuilder()
                .withMessage(Constants.message)
                .withAlignment(.bottom)
                .build()
                .previewDisplayName("Message only")
            MessageViewBuilder()
                .withMessage(Constants.message)
                .withAlignment(.top)
                .build()
                .previewDisplayName("Message only")
        }
    }
}
