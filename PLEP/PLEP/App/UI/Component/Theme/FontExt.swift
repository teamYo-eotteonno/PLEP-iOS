//
//  FontExt.swift
//  PLEP
//
//  Created by 이다경 on 4/8/25.
//

import SwiftUI

extension UIFont {
    static func pretendard(size fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        let familyName = "Pretendard"

        var weightString: String
        switch weight {
        case .black:
            weightString = "Black"
        case .bold:
            weightString = "Bold"
        case .heavy:
            weightString = "ExtraBold"
        case .ultraLight:
            weightString = "ExtraLight"
        case .light:
            weightString = "Light"
        case .medium:
            weightString = "Medium"
        case .regular:
            weightString = "Regular"
        case .semibold:
            weightString = "SemiBold"
        case .thin:
            weightString = "Thin"
        default:
            weightString = "Regular"
        }

        return UIFont(name: "\(familyName)-\(weightString)", size: fontSize)
            ?? .systemFont(ofSize: fontSize, weight: weight)
    }
}

struct TextStyle {
    let font: Font
    let lineHeight: CGFloat
    let fontSize: CGFloat
}

// MARK: - TextStyle Presets

extension TextStyle {
    private static func pretendardStyle(size: CGFloat, weight: UIFont.Weight, lineHeight: CGFloat) -> TextStyle {
        return TextStyle(
            font: Font(UIFont.pretendard(size: size, weight: weight)),
            lineHeight: lineHeight,
            fontSize: size
        )
    }

    struct Body {
        static let `default` = pretendardStyle(size: 17, weight: .medium, lineHeight: 24)
        static let bold = pretendardStyle(size: 17, weight: .bold, lineHeight: 24)
    }

    struct LargeBodyCopy {
        static let `default` = pretendardStyle(size: 22, weight: .medium, lineHeight: 32)
        static let bold = pretendardStyle(size: 22, weight: .bold, lineHeight: 32)
    }

    struct Callout {
        static let `default` = pretendardStyle(size: 16, weight: .medium, lineHeight: 20)
        static let bold = pretendardStyle(size: 16, weight: .bold, lineHeight: 20)
    }

    struct Caption1 {
        static let `default` = pretendardStyle(size: 12, weight: .medium, lineHeight: 16)
        static let bold = pretendardStyle(size: 12, weight: .bold, lineHeight: 16)
    }

    struct Caption2 {
        static let `default` = pretendardStyle(size: 11, weight: .medium, lineHeight: 16)
        static let bold = pretendardStyle(size: 11, weight: .bold, lineHeight: 16)
    }

    struct Footnote {
        static let `default` = pretendardStyle(size: 13, weight: .medium, lineHeight: 16)
        static let bold = pretendardStyle(size: 13, weight: .bold, lineHeight: 16)
    }

    struct Overline {
        static let `default` = pretendardStyle(size: 15, weight: .medium, lineHeight: 20)
        static let bold = pretendardStyle(size: 15, weight: .bold, lineHeight: 20)
    }

    struct Headline {
        static let `default` = pretendardStyle(size: 17, weight: .medium, lineHeight: 22)
        static let bold = pretendardStyle(size: 17, weight: .bold, lineHeight: 22)
    }

    struct Subheadline {
        static let `default` = pretendardStyle(size: 15, weight: .medium, lineHeight: 20)
        static let bold = pretendardStyle(size: 15, weight: .bold, lineHeight: 20)
    }

    struct LargeTitle {
        static let `default` = pretendardStyle(size: 34, weight: .medium, lineHeight: 40)
        static let bold = pretendardStyle(size: 34, weight: .bold, lineHeight: 40)
    }

    struct XLargeTitle {
        static let `default` = pretendardStyle(size: 54, weight: .medium, lineHeight: 64)
        static let bold = pretendardStyle(size: 54, weight: .bold, lineHeight: 64)
    }

    struct XXLargeTitle {
        static let `default` = pretendardStyle(size: 68, weight: .medium, lineHeight: 80)
        static let bold = pretendardStyle(size: 68, weight: .bold, lineHeight: 80)
    }

    struct Title1 {
        static let `default` = pretendardStyle(size: 28, weight: .medium, lineHeight: 32)
        static let bold = pretendardStyle(size: 28, weight: .bold, lineHeight: 32)
    }

    struct Title2 {
        static let `default` = pretendardStyle(size: 22, weight: .medium, lineHeight: 28)
        static let bold = pretendardStyle(size: 22, weight: .bold, lineHeight: 28)
    }

    struct Title3 {
        static let `default` = pretendardStyle(size: 20, weight: .medium, lineHeight: 24)
        static let bold = pretendardStyle(size: 20, weight: .semibold, lineHeight: 24)
    }

    struct Button {
        static let smalltext = pretendardStyle(size: 16, weight: .semibold, lineHeight: 24)
        static let text = pretendardStyle(size: 23, weight: .semibold, lineHeight: 24)
        static let icon = pretendardStyle(size: 23, weight: .semibold, lineHeight: 24)
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
