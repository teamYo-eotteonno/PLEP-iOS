//
//  PLEPTextFieldType.swift
//  PLEP
//
//  Created by 이다경 on 4/11/25.
//

import SwiftUI

enum PLEPTextFieldType {
    case null, `in`, focus, error, security
}

enum PLEPTextFieldColor {
    case gray, dark
}

// MARK: - Style Resolver

struct PLEPTextFieldStyle {
    let color: PLEPTextFieldColor
    let type: PLEPTextFieldType
    let login: Bool
    
    var isSecure: Bool {
        return type == .security
    }

    var showBorder: Bool {
        return type == .focus || type == .error
    }

    var borderWidth: CGFloat {
        showBorder ? 1 : 0
    }

    var textColor: Color {
        switch color {
        case .gray:
            switch type {
            case .null: return .txt["quarternary"]
            default: return .txt["secondary"]
            }
        case .dark:
            switch type {
            case .null: return .txtop.white.tertiary
            default: return .txtop.white.primary
        }
        }
    }

    var backgroundColor: Color {
        switch color {
        case .gray: return .g[100]
        case .dark: return .b[700]
        }
    }

    var borderColor: Color {
        switch type {
        case .error: return .s["error"]
        default: return .clear
        }
    }
}
