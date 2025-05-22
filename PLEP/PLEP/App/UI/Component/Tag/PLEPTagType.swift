//
//  PLEPTagType.swift
//  PLEP
//
//  Created by 이다경 on 5/21/25.
//

import SwiftUI

enum PLEPTagType {
    case filled, outlined, neutral
}

enum PLEPTagSize {
    case small, medium, large
}

struct PLEPTagStyle {
    let type: PLEPTagType
    let size: PLEPTagSize
    let enabled: Bool

    var height: CGFloat {
        switch size {
        case .large: return 58
        case .medium: return 51
        case .small: return 33
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
        case .filled: return enabled ? .icon.white : .icon.white.opacity(0.4)
        case .outlined, .neutral: return enabled ? .txt.secondary : .txt.secondary.opacity(0.4)
        }
    }

    var backgroundColor: Color {
        switch type {
        case .filled: return enabled ? .p[500] : .p[500].opacity(0.4)
        case .outlined: return enabled ? .g[0] : .g[0].opacity(0.4)
        case .neutral: return enabled ? .g[100] : .g[100].opacity(0.4)
        }
    }

    var borderColor: Color {
        switch type {
        case .filled: return .clear
        case .outlined: return enabled ? .g[200] : .g[200].opacity(0.4)
        case .neutral: return .clear
        }
    }

    var borderWidth: CGFloat {
        return type == .outlined ? 1 : 0
    }
    
    var width: CGFloat {
        switch size {
        case .large: return 20
        case .medium: return 20
        case .small: return 16
        }
    }
}
