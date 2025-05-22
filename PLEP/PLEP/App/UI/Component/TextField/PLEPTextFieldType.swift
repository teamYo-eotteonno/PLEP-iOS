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

// MARK: - Style Resolver

struct PLEPTextFieldStyle {
    let type: PLEPTextFieldType
    
    var isSecure: Bool {
        return type == .security
    }

    var showBorder: Bool {
        return type == .focus || type == .error
    }

    var borderWidth: CGFloat {
        showBorder ? 2 : 0
    }

    var borderColor: Color {
        switch type {
        case .error: return .s.error
        default: return .clear
        }
    }
}
