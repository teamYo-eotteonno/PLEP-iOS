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

    struct Title {
        static let header1 = pretendardStyle(size: 64, weight: .bold, lineHeight: 140)
        static let header2 = pretendardStyle(size: 40, weight: .bold, lineHeight: 140)
        static let header3 = pretendardStyle(size: 27, weight: .bold, lineHeight: 140)
        static let subtitle = pretendardStyle(size: 24, weight: .medium, lineHeight: 130)
        static let pre = pretendardStyle(size: 12, weight: .bold, lineHeight: 14.3)
    }

    struct Body {
        static let `default` = pretendardStyle(size: 16, weight: .medium, lineHeight: 140)
        static let bold = pretendardStyle(size: 16, weight: .bold, lineHeight: 19.1)
        static let small = pretendardStyle(size: 14, weight: .medium, lineHeight: 14.3)
    }
    
    struct Button {
        static let `default` = pretendardStyle(size: 16, weight: .medium, lineHeight: 19.1)
        static let bold = pretendardStyle(size: 16, weight: .bold, lineHeight: 19.1)
    }
    
    static let logo = TextStyle(font: .custom("TitanOne", size: 80), lineHeight: 92, fontSize: 80)
    
    static let end = TextStyle(font: .custom("OTMBC-1961M", size: 60), lineHeight: 140, fontSize: 60)

    static let title = Title.self
    static let body = Body.self
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

// MARK: - TextStyle Proxy 구조 (Generic)

struct TextStyleAccessProxy<V: View> {
    let view: V
    
    var title: TextStyleProxy<TextStyle.Title.Type> {
        TextStyleProxy(view: view, styleSet: TextStyle.title)
    }

    var body: TextStyleProxy<TextStyle.Body.Type> {
        TextStyleProxy(view: view, styleSet: TextStyle.body)
    }

    var button: TextStyleProxy<TextStyle.Button.Type> {
        TextStyleProxy(view: view, styleSet: TextStyle.button)
    }
    
    var logo: some View {
        view.textStyle(TextStyle.logo)
    }
    
    var end: some View {
        view.textStyle(TextStyle.end)
    }
}

struct TextStyleProxy<StyleSet> {
    let view: any View
    let styleSet: StyleSet

    var `default`: some View {
        if let set = styleSet as? TextStyle.Body.Type {
            return AnyView(view.textStyle(set.default))
        } else if let set = styleSet as? TextStyle.Button.Type {
            return AnyView(view.textStyle(set.default))
        } else if let set = styleSet as? TextStyle.Title.Type {
            return AnyView(view)
        } else {
            return AnyView(view)
        }
    }

    var bold: some View {
        if let set = styleSet as? TextStyle.Body.Type {
            return AnyView(view.textStyle(set.bold))
        } else if let set = styleSet as? TextStyle.Button.Type {
            return AnyView(view.textStyle(set.bold))
        } else {
            return AnyView(view)
        }
    }

    var small: some View {
        if let set = styleSet as? TextStyle.Body.Type {
            return AnyView(view.textStyle(set.small))
        } else {
            return AnyView(view)
        }
    }

    var header1: some View {
        if let set = styleSet as? TextStyle.Title.Type {
            return AnyView(view.textStyle(set.header1))
        } else {
            return AnyView(view)
        }
    }

    var header2: some View {
        if let set = styleSet as? TextStyle.Title.Type {
            return AnyView(view.textStyle(set.header2))
        } else {
            return AnyView(view)
        }
    }

    var header3: some View {
        if let set = styleSet as? TextStyle.Title.Type {
            return AnyView(view.textStyle(set.header3))
        } else {
            return AnyView(view)
        }
    }

    var subtitle: some View {
        if let set = styleSet as? TextStyle.Title.Type {
            return AnyView(view.textStyle(set.subtitle))
        } else {
            return AnyView(view)
        }
    }

    var pre: some View {
        if let set = styleSet as? TextStyle.Title.Type {
            return AnyView(view.textStyle(set.pre))
        } else {
            return AnyView(view)
        }
    }
}
