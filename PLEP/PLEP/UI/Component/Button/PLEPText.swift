//
//  PLEPText.swift
//  PLEP
//
//  Created by 이다경 on 4/6/25.
//

import SwiftUI

// MARK: - TextStyle 정의

struct TextStyle {
    let font: Font
    let lineHeight: CGFloat
    let fontSize: CGFloat
}

// MARK: - TextStyle Presets

extension TextStyle {
    struct Body {
        static let `default` = TextStyle(
            font: .system(size: 17, weight: .medium),
            lineHeight: 24,
            fontSize: 17
        )
        static let bold = TextStyle(
            font: .system(size: 17, weight: .bold),
            lineHeight: 24,
            fontSize: 17
        )
    }

    struct LargeBodyCopy {
        static let `default` = TextStyle(
            font: .system(size: 22, weight: .medium),
            lineHeight: 32,
            fontSize: 22
        )
        static let bold = TextStyle(
            font: .system(size: 22, weight: .bold),
            lineHeight: 32,
            fontSize: 22
        )
    }
    
    struct Callout {
        static let `default` = TextStyle(
            font: .system(size: 16, weight: .medium),
            lineHeight: 20,
            fontSize: 16
        )
        static let bold = TextStyle(
            font: .system(size: 16, weight: .bold),
            lineHeight: 20,
            fontSize: 22
        )
    }
    
    struct Caption1 {
        static let `default` = TextStyle(
            font: .system(size: 12, weight: .medium),
            lineHeight: 16,
            fontSize: 12
        )
        static let bold = TextStyle(
            font: .system(size: 12, weight: .bold),
            lineHeight: 16,
            fontSize: 12
        )
    }
    
    struct Caption2 {
        static let `default` = TextStyle(
            font: .system(size: 11, weight: .medium),
            lineHeight: 16,
            fontSize: 11
        )
        static let bold = TextStyle(
            font: .system(size: 11, weight: .bold),
            lineHeight: 16,
            fontSize: 11
        )
    }
    
    struct Footnote {
        static let `default` = TextStyle(
            font: .system(size: 13, weight: .medium),
            lineHeight: 16,
            fontSize: 13
        )
        static let bold = TextStyle(
            font: .system(size: 13, weight: .bold),
            lineHeight: 16,
            fontSize: 13
        )
    }
    
    struct Overline {
        static let `default` = TextStyle(
            font: .system(size: 15, weight: .medium),
            lineHeight: 20,
            fontSize: 15
        )
        static let bold = TextStyle(
            font: .system(size: 15, weight: .bold),
            lineHeight: 20,
            fontSize: 15
        )
    }
    
    struct Headline {
        static let `default` = TextStyle(
            font: .system(size: 17, weight: .medium),
            lineHeight: 22,
            fontSize: 17
        )
        static let bold = TextStyle(
            font: .system(size: 17, weight: .bold),
            lineHeight: 22,
            fontSize: 17
        )
    }
    
    struct Subheadline {
        static let `default` = TextStyle(
            font: .system(size: 15, weight: .medium),
            lineHeight: 20,
            fontSize: 15
        )
        static let bold = TextStyle(
            font: .system(size: 15, weight: .bold),
            lineHeight: 20,
            fontSize: 15
        )
    }
    
    struct LargeTitle {
        static let `default` = TextStyle(
            font: .system(size: 34, weight: .medium),
            lineHeight: 40,
            fontSize: 34
        )
        static let bold = TextStyle(
            font: .system(size: 34, weight: .bold),
            lineHeight: 40,
            fontSize: 34
        )
    }
    
    struct XLargeTitle {
        static let `default` = TextStyle(
            font: .system(size: 54, weight: .medium),
            lineHeight: 64,
            fontSize: 54
        )
        static let bold = TextStyle(
            font: .system(size: 54, weight: .bold),
            lineHeight: 64,
            fontSize: 54
        )
    }
    
    struct XXLargeTitle {
        static let `default` = TextStyle(
            font: .system(size: 68, weight: .medium),
            lineHeight: 80,
            fontSize: 68
        )
        static let bold = TextStyle(
            font: .system(size: 68, weight: .bold),
            lineHeight: 80,
            fontSize: 68
        )
    }
    
    struct Title1 {
        static let `default` = TextStyle(
            font: .system(size: 28, weight: .medium),
            lineHeight: 32,
            fontSize: 28
        )
        static let bold = TextStyle(
            font: .system(size: 28, weight: .bold),
            lineHeight: 32,
            fontSize: 28
        )
    }
    
    struct Title2 {
        static let `default` = TextStyle(
            font: .system(size: 22, weight: .medium),
            lineHeight: 28,
            fontSize: 22
        )
        static let bold = TextStyle(
            font: .system(size: 22, weight: .bold),
            lineHeight: 28,
            fontSize: 22
        )
    }
    
    struct Title3 {
        static let `default` = TextStyle(
            font: .system(size: 20, weight: .medium),
            lineHeight: 24,
            fontSize: 20
        )
        static let bold = TextStyle(
            font: .system(size: 20, weight: .semibold),
            lineHeight: 24,
            fontSize: 20
        )
    }
    
    struct Button {
        static let smalltext = TextStyle(
            font: .system(size: 16, weight: .semibold),
            lineHeight: 24,
            fontSize: 16
        )
        static let text = TextStyle(
            font: .system(size: 23, weight: .semibold),
            lineHeight: 24,
            fontSize: 23
        )
        static let icon = TextStyle(
            font: .system(size: 23, weight: .semibold),
            lineHeight: 24,
            fontSize: 23
        )
    }

    static let body = Body.self
    static let largebodycopy = LargeBodyCopy.self
    static let callout = Callout.self
    static let caption1 = Caption1.self
    static let caption2 = Caption2.self
    static let footnote = Footnote.self
    static let overline = Overline.self
    static let headline = Headline.self
    static let subheadline = Subheadline.self
    static let largetitle = LargeTitle.self
    static let xlargetitle = XLargeTitle.self
    static let xxlargetitle = XXLargeTitle.self
    static let title1 = Title1.self
    static let title2 = Title2.self
    static let title3 = Title3.self
    static let button = Button.self
}

// MARK: - ViewModifier

struct TextStyleModifier: ViewModifier {
    let style: TextStyle

    func body(content: Content) -> some View {
        content
            .font(style.font)
            .lineSpacing(style.lineHeight - style.fontSize)
    }
}

// MARK: - View Extension

extension View {
    func textStyle(_ style: TextStyle) -> some View {
        modifier(TextStyleModifier(style: style))
    }

    var textStyle: TextStyleAccessProxy<Self> {
        TextStyleAccessProxy(view: self)
    }
}

// MARK: - Proxy 구조 (Generic)

struct TextStyleAccessProxy<V: View> {
    let view: V
    
    var body: TextStyleProxy {
        TextStyleProxy(view: view, styleSet: TextStyle.body)
    }
    
    var largeBodyCopy: TextStyleProxy {
        TextStyleProxy(view: view, styleSet: TextStyle.largebodycopy)
    }
    
    
    struct TextStyleProxy {
        let view: V
        let styleSet: Any
        
        var `default`: some View {
            if let set = styleSet as? TextStyle.Body.Type {
                return AnyView(view.textStyle(set.default))
            } else if let set = styleSet as? TextStyle.LargeBodyCopy.Type {
                return AnyView(view.textStyle(set.default))
            } else {
                return AnyView(view)
            }
        }
        
        var bold: some View {
            if let set = styleSet as? TextStyle.Body.Type {
                return AnyView(view.textStyle(set.bold))
            } else if let set = styleSet as? TextStyle.LargeBodyCopy.Type {
                return AnyView(view.textStyle(set.bold))
            } else {
                return AnyView(view)
            }
        }
    }
}
