//
//  PLEPDropdownType.swift
//  PLEP
//
//  Created by 이다경 on 5/8/25.
//

import SwiftUI

enum PLEPDropdownType {
    case light, dark
}

struct PLEPDropdownStyle {
    let type: PLEPDropdownType
    
    var textbackColor: Color {
        switch type {
        case .light: return .g[100]
        case .dark: return .g[800]
        }
    }
    
    var contentbackColor: Color {
        switch type {
        case .light: return .b[0]
        case .dark: return .g[800]
        }
    }
    
    var titletextColor: Color {
        switch type {
        case .light: return .txtop.black.quarternary
        case .dark: return .txtop.white.primary
        }
    }
    
    var contenttextColor: Color {
        switch type {
        case .light: return .txtop.black.primary
        case .dark: return .txtop.white.primary
        }
    }
}
