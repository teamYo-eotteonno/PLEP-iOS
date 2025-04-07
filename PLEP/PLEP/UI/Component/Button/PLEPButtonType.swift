//
//  PLEPButtonType.swift
//  PLEP
//
//  Created by 이다경 on 4/6/25.
//

import SwiftUI

enum PLEPButtonType {
    case filled, outlined, neutral
}

enum PLEPButtonSize {
    case sSmall, small, medium, large, lLarge
}

enum PLEPButtonColor {
    case purple, dark
}

// MARK: - Style Resolver

struct PLEPButtonStyle {
    let type: PLEPButtonType
    let size: PLEPButtonSize
    let enabled: Bool
    let color: PLEPButtonColor

    var height: CGFloat {
        switch size {
        case .lLarge: return 80
        case .large: return 55
        case .medium: return 51
        case .small: return 52
        case .sSmall: return 34
        }
    }

    var textStyle: TextStyle {
        switch size {
        case .lLarge: return TextStyle.largetitle.bold
        case .large: return TextStyle.button.icon
        case .medium: return TextStyle.button.text
        case .small: return TextStyle.button.smalltext
        case .sSmall: return TextStyle.caption1.bold
        }
    }

    var textColor: Color {
        if type == .filled {
            return .txtop.white.primary
        } else {
            return enabled ? .txt["tertiary"] : .txtop.black.tertiary
        }
    }

    var backgroundColor: Color {
        switch type {
        case .filled:
            switch (enabled, color) {
            case (true, .purple): return .p[500]
            case (false, .purple): return .p[300]
            case (true, .dark): return .b[600]
            case (false, .dark): return .b[600].opacity(0.6)
            }
        case .outlined:
            return .g[0]
        case .neutral:
            switch (enabled, color) {
            case (true, .purple): return .g[100]
            case (false, .purple): return .g[100].opacity(0.6)
            case (true, .dark): return .p[50]
            case (false, .dark): return .p[50].opacity(0.6)
            }
        }
    }

    var borderColor: Color {
        guard type == .outlined else { return .clear }

        switch (enabled, color) {
        case (true, .purple): return .g[200]
        case (false, .purple): return .g[200].opacity(0.6)
        case (true, .dark): return .p[500]
        case (false, .dark): return .p[500].opacity(0.6)
        }
    }

    var borderWidth: CGFloat {
        return type == .outlined ? 1 : 0
    }
}
