////
////  PLEPTagType.swift
////  PLEP
////
////  Created by 이다경 on 5/21/25.
////
//
//import SwiftUI
//
//enum PLEPTagType {
//    case filled, outlined, neutral
//}
//
//enum PLEPTagSize {
//    case small, medium, large
//}
//
//struct PLEPTagStyle {
//    let type: PLEPTagType
//    let size: PLEPTagSize
//    let enabled: Bool
//
//    var height: CGFloat {
//        switch size {
//        case .large: return 58
//        case .medium: return 51
//        case .small: return 33
//        }
//    }
//
//    var textStyle: TextStyle {
//        switch size {
//        case .large: return TextStyle.title3.default
//        case .medium: return TextStyle.button.text
//        case .small: return TextStyle.button.smalltext
//        }
//    }
//
//    var textColor: Color {
//        if type == .filled {
//            return .txtop.white.primary
//        } else {
//            return enabled ? .txt["tertiary"] : .txtop.black.tertiary
//        }
//    }
//
//    var backgroundColor: Color {
//        switch type {
//        case .filled:
//            switch (enabled, color) {
//            case (true, .purple): return .p[500]
//            case (false, .purple): return .p[300]
//            case (true, .dark): return .b[600]
//            case (false, .dark): return .b[600].opacity(0.6)
//            }
//        case .outlined:
//            return .g[0]
//        case .neutral:
//            switch (enabled, color) {
//            case (true, .purple): return .g[100]
//            case (false, .purple): return .g[100].opacity(0.6)
//            case (true, .dark): return .p[50]
//            case (false, .dark): return .p[50].opacity(0.6)
//            }
//        }
//    }
//
//    var borderColor: Color {
//        guard type == .outlined else { return .clear }
//
//        switch (enabled, color) {
//        case (true, .purple): return .g[200]
//        case (false, .purple): return .g[200].opacity(0.6)
//        case (true, .dark): return .p[500]
//        case (false, .dark): return .p[500].opacity(0.6)
//        }
//    }
//
//    var borderWidth: CGFloat {
//        return type == .outlined ? 1 : 0
//    }
//}
