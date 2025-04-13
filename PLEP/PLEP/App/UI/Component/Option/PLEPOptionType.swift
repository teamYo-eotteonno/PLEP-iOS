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
        switch (type, state) {
        case (.filled, true): return .p[500]
        case (.filled, false): return .p[500].opacity(0.2)
        case (.outlined, true): return .g[100]
        case (.outlined, false): return .g[100].opacity(0.4)
        case (.neutral, true): return .g[300]
        case (.neutral, false): return .g[300].opacity(0.4)
        }
    }

    var borderColor: Color {
        switch (type, state) {
        case (.filled, true): return .p[500]
        case (.filled, false): return .p[500].opacity(0.2)
        case (.outlined, true): return .g[600]
        case (.outlined, false): return .g[600].opacity(0.4)
        case (.neutral, true): return .g[300]
        case (.neutral, false): return .g[300].opacity(0.4)
        }
    }

    var borderWidth: CGFloat {
        return 0.5
    }
}
