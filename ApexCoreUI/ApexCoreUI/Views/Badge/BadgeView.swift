//
//  BadgeView.swift
//  ApexCoreUI
//
//  Created by Olivier Rigault on 16/09/2021.
//

import SwiftUI
import ApexCore

public struct BadgeView: View {
    
    let text: String?
    let font: Font
    let backgroundColor: Color
    let textColor: Color
    let horizontalInset: CGFloat
    let verticalInset: CGFloat
    
    public init(text: String?,
                font: Font,
                backgroundColor: Color,
                textColor: Color,
                horizontalInset: CGFloat,
                verticalInset: CGFloat) {
        self.text = text
        self.font = font
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.horizontalInset = horizontalInset
        self.verticalInset = verticalInset
    }

    public var body: some View {
        if let text = text {
            Text(text)
                .font(font)
                .padding(EdgeInsets(top: verticalInset,
                                    leading: horizontalInset,
                                    bottom: verticalInset,
                                    trailing: horizontalInset))
                .background(
                    Capsule().fill(backgroundColor))
                .foregroundColor(textColor)
        } else {
            EmptyView()
        }
    }
}

public class BadgeViewBuilder: BuilderProtocol {
    
    private var text: String? = nil
    private var font = Font.caption
    private var backgroundColor = Color.blue
    private var textColor = Color.white
    private var horizontalInset: CGFloat = 8
    private var verticalInset: CGFloat = 4

    public init() {}
    
    public func withInt(_ int: Int) -> BadgeViewBuilder {
        self.text = String(int)
        return self
    }

    public func withText(_ text: String) -> BadgeViewBuilder {
        self.text = text
        return self
    }
    
    public func withFont(_ font: Font) -> BadgeViewBuilder {
        self.font = font
        return self
    }
    
    public func withBackgroundColor(_ backgroundColor: Color) -> BadgeViewBuilder {
        self.backgroundColor = backgroundColor
        return self
    }
    
    public func withTextColor(_ textColor: Color) -> BadgeViewBuilder {
        self.textColor = textColor
        return self
    }
    
    public func withHorizontalInset(_ horizontalInset: CGFloat) -> BadgeViewBuilder {
        self.horizontalInset = horizontalInset
        return self
    }
    
    public func withVerticalInset(_ verticalInset: CGFloat) -> BadgeViewBuilder {
        self.verticalInset = verticalInset
        return self
    }
    
    public func build() -> some View {
        BadgeView(text: text,
                  font: font,
                  backgroundColor: backgroundColor,
                  textColor: textColor,
                  horizontalInset: horizontalInset,
                  verticalInset: verticalInset)
    }
}

public class BadgeView_Previews: PreviewProvider {
    
    public static var previews: some View {
        Group {
            BadgeViewBuilder()
                .build()
                .sizeThatFitPreview(with: "No text, so should be empty")
            BadgeViewBuilder()
                .withText("Hello, world!")
                .build()
                .sizeThatFitPreview(with: "Default")
            BadgeViewBuilder()
                .withInt(123456)
                .withFont(.title)
                .withBackgroundColor(.gray)
                .withTextColor(.purple)
                .withHorizontalInset(30)
                .withVerticalInset(20)
                .build()
                .sizeThatFitPreview(with: "Big badge")
        }
    }
}
