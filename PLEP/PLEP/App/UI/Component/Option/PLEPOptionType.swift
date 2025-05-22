//
//  PLEPOptionType.swift
//  PLEP
//
//  Created by 이다경 on 4/13/25.
//

import SwiftUI

enum PLEPOptionType {
    case filled, outlined, neutral
}

// MARK: - Style Resolver

struct PLEPOptionStyle {
    let type: PLEPOptionType
    let state: Bool

    var backgroundColor: Color {
        switch type {
        case .filled: return state ? .p[500] : .p[500].opacity(0.2)
        case .outlined: return state ? .g[200] : .g[200].opacity(0.4)
        case .neutral: return state ? .g[400] : .g[400].opacity(0.4)
        }
    }

    var checkColor: Color {
        switch type {
        case .filled: return state ? .icon.white : .icon.white.opacity(0.2)
        case .outlined: return state ? .txt.tertiary : .txt.tertiary.opacity(0.4)
        case .neutral: return state ? .txt.tertiary : .txt.tertiary.opacity(0.4)
        }
    }
    
    var borderColor: Color {
        switch type {
        case .filled: return state ? .p[500] : .p[500].opacity(0.2)
        case .outlined: return state ? .txt.tertiary : .txt.tertiary.opacity(0.4)
        case .neutral: return state ? .g[400] : .g[400].opacity(0.4)
        }
    }

    var borderWidth: CGFloat {
        return 1
    }
}
