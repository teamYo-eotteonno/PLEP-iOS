//
//  PLEPColor.swift
//  PLEP
//
//  Created by 이다경 on 4/6/25.
//

import SwiftUICore
import SwiftUI

extension Color {
    struct Palette_p {
        private let shades: [Int: Color] = [
            50:  Color(hex: "#F1ECFE"),
            100: Color(hex: "#E3D8FC"),
            200: Color(hex: "#C7B1F9"),
            300: Color(hex: "#AB8AF7"),
            400: Color(hex: "#8F64F4"),
            500: Color(hex: "#733DF1"),
            600: Color(hex: "#5C31C1"),
            700: Color(hex: "#452491"),
            800: Color(hex: "#2E1860"),
            900: Color(hex: "#170C30")
        ]

        subscript(index: Int) -> Color {
            return shades[index] ?? .black
        }
    }
    
    struct Palette_g {
        private let shades: [Int: Color] = [
            0: Color.dynamic(light: Color(hex: "#FFFFFF"), dark: Color(hex: "#15131A")),
            50: Color.dynamic(light: Color(hex: "#FBFAFB"), dark: Color(hex: "#201D27")),
            100: Color.dynamic(light: Color(hex: "#F6F5F8"), dark: Color(hex: "#2B2734")),
            200: Color.dynamic(light: Color(hex: "#EDEBF0"), dark: Color(hex: "#35303F")),
            300: Color.dynamic(light: Color(hex: "#E4E1E9"), dark: Color(hex: "#3E3849")),
            400: Color.dynamic(light: Color(hex: "#DBD7E2"), dark: Color(hex: "#454051")),
            500: Color.dynamic(light: Color(hex: "#D2CDDB"), dark: Color(hex: "#4C4656")),
            600: Color.dynamic(light: Color(hex: "#A8A4AF"), dark: Color(hex: "#514C5B")),
            700: Color.dynamic(light: Color(hex: "#7E7B83"), dark: Color(hex: "#56525E")),
            800: Color.dynamic(light: Color(hex: "#545257"), dark: Color(hex: "#5B5860")),
            900: Color.dynamic(light: Color(hex: "#2A292C"), dark: Color(hex: "#5E5D61"))
        ]

        subscript(index: Int) -> Color {
            return shades[index] ?? .black
        }
    }
    
    struct Palette_s {
        private let named: [String: Color] = [
            "success": Color(hex: "#01D281"),
            "error": Color(hex: "#CF4747"),
            "warning": Color(hex: "#E8C141"),
        ]
        
        subscript(key: String) -> Color {
            named[key] ?? .black
        }
    }
    
    struct Palette_text {
        private let named: [String: Color] = [
            "primary": Color.dynamic(light: Color(hex: "#151118"), dark: Color(hex: "#FFFFFF")),
            "secondary": Color.dynamic(light: Color(hex: "#151118"), dark: Color(hex: "#FFFFFF")).opacity(0.72),
            "tertiary": Color.dynamic(light: Color(hex: "#151118"), dark: Color(hex: "#FFFFFF")).opacity(0.48),
            "quartemary": Color.dynamic(light: Color(hex: "#151118"), dark: Color(hex: "#FFFFFF")).opacity(0.32),
        ]
        
        subscript(key: String) -> Color {
            named[key] ?? .black
        }
    }
    
    struct Palette_icon {
        private let named: [String: Color] = [
            "primary": Color(hex: "#42394D"),
            "secondary": Color(hex: "#4E4653"),
            "tertiary": Color(hex: "#827788"),
            "quartemary": Color(hex: "#B4AFB6"),
            "while": Color(hex: "#FFFFFF"),
        ]
        
        subscript(key: String) -> Color {
            named[key] ?? .black
        }
    }
    
    struct Palette_file {
        private let named: [String: Color] = [
            "red": Color(hex: "#E16868"),
            "orange": Color(hex: "#E19E68"),
            "yellow": Color(hex: "#E1D568"),
            "lame": Color(hex: "#B9E168"),
            "green": Color(hex: "#68E180"),
            "sky": Color(hex: "#68D5E1"),
            "blue": Color(hex: "#6882E1"),
            "purple": Color(hex: "#8068E1"),
            "magenta": Color(hex: "#CD68E1"),
            "pink": Color(hex: "#E168B1")
        ]
        
        subscript(key: String) -> Color {
            named[key] ?? .black
        }
    }

    static let p = Palette_p()
    static let g = Palette_g()
    static let s = Palette_s()
    static let txt = Palette_text()
    static let icon = Palette_icon()
    static let file = Palette_file()
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let r, g, b, a: UInt64
        switch hex.count {
        case 3:
            (r, g, b, a) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17, 255)
        case 6:
            (r, g, b, a) = (int >> 16, int >> 8 & 0xFF, int & 0xFF, 255)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b, a) = (1, 1, 1, 1)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

extension Color {
    static func dynamic(light: Color, dark: Color) -> Color {
        return Color(UIColor { trait in
            trait.userInterfaceStyle == .dark ? UIColor(dark) : UIColor(light)
        })
    }
}
