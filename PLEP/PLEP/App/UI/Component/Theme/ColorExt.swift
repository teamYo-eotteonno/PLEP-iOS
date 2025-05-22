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
        var success: Color { Color(hex: "#01D281") }
        var error: Color { Color(hex: "#CF4747") }
        var warning: Color { Color(hex: "#E8C141") }
    }
    
    struct Palette_text {
        var primary: Color { Color.dynamic(light: Color(hex: "#151118"), dark: Color(hex: "#FFFFFF")) }
        var secondary: Color { Color.dynamic(light: Color(hex: "#151118"), dark: Color(hex: "#FFFFFF")).opacity(0.72) }
        var tertiary: Color { Color.dynamic(light: Color(hex: "#151118"), dark: Color(hex: "#FFFFFF")).opacity(0.48) }
        var quartemary: Color { Color.dynamic(light: Color(hex: "#151118"), dark: Color(hex: "#FFFFFF")).opacity(0.32) }
    }

    
    struct Palette_icon {
        var primary: Color { Color(hex: "#42394D") }
        var secondary: Color { Color(hex: "#4E4653") }
        var tertiary: Color { Color(hex: "#827788") }
        var quartemary: Color { Color(hex: "#B4AFB6") }
        var white: Color { Color(hex: "#FFFFFF") }
    }

    
    struct Palette_file {
        var red: Color { Color(hex: "#E16868") }
        var orange: Color { Color(hex: "#E19E68") }
        var yellow: Color { Color(hex: "#E1D568") }
        var lame: Color { Color(hex: "#B9E168") }
        var green: Color { Color(hex: "#68E180") }
        var sky: Color { Color(hex: "#68D5E1") }
        var blue: Color { Color(hex: "#6882E1") }
        var purple: Color { Color(hex: "#8068E1") }
        var magenta: Color { Color(hex: "#CD68E1") }
        var pink: Color { Color(hex: "#E168B1") }
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
