//
//  PLEPToggleType.swift
//  PLEP
//
//  Created by 이다경 on 4/12/25.
//

import SwiftUI

enum PLEPToggleType {
    case dark, light
}

enum PLEPToggleColor {
    case purple, gray, black
}

// MARK: - Style Resolver

struct PLEPToggleStyle {
    let type: PLEPToggleType
    let enabled: Bool
    let color: PLEPToggleColor

    var backgroundColor: Color {
        switch (color, enabled) {
            case (.purple, true): return .p[500]
            case (.purple, false): return .p[500].opacity(0.6)
            case (.gray, true): return .g[400]
            case (.gray, false): return .g[400].opacity(0.6)
            case (.black, true): return .b[500]
            case (.black, false): return .b[500].opacity(0.6)
        }
    }

    var foregroundColor: Color {
        switch type {
        case .dark: return .b[500]
        case .light: return .txtop.white.primary
        }
    }

}
