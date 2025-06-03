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
    case small, medium, large
}

// MARK: - Style Resolver

struct PLEPButtonStyle {
    let type: PLEPButtonType
    let size: PLEPButtonSize
    let enabled: Bool

    var height: CGFloat {
        switch size {
        case .large: return 70
        case .medium: return 57
        case .small: return 42
        }
    }

    var textStyle: TextStyle {
        switch size {
        case .large: return .title.header3
        case .medium: return .title.subtitle
        case .small: return .body.bold
        }
    }

    var textColor: Color {
        switch type {
        case .filled: return enabled ? .icon.white : .icon.white.opacity(0.6)
        case .outlined: return enabled ? .icon.tertiary : .icon.tertiary.opacity(0.6)
        case .neutral: return enabled ? .txt.tertiary : .txt.tertiary.opacity(0.6)
        }
    }

    var backgroundColor: Color {
        switch type {
        case .filled: return enabled ? .p[500] : .p[500].opacity(0.6)
        case .outlined: return enabled ? .g[0] : .g[0].opacity(0.6)
        case .neutral: return enabled ? .g[200] : .g[200].opacity(0.6)
        }
    }

    var borderColor: Color {
        switch type {
        case .filled: return .clear
        case .outlined: return enabled ? .g[200] : .g[200].opacity(0.6)
        case .neutral: return .clear
        }
    }

    var borderWidth: CGFloat {
        return type == .outlined ? 4 : 0
    }
}
