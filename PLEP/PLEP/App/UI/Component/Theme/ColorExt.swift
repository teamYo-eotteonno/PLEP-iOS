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
            0: Color(hex: "#FFFFFF"),
            50:  Color(hex: "#FBFAFB"),
            100: Color(hex: "#F6F5F8"),
            200: Color(hex: "#EDEBF0"),
            300: Color(hex: "#E4E1E9"),
            400: Color(hex: "#DBD7E2"),
            500: Color(hex: "#D2CDDB"),
            600: Color(hex: "#A8A4AF"),
            700: Color(hex: "#7E7B83"),
            800: Color(hex: "#545257"),
            900: Color(hex: "#2A292C")
        ]

        subscript(index: Int) -> Color {
            return shades[index] ?? .black
        }
    }
    
    struct Palette_b {
        private let shades: [Int: Color] = [
            50:  Color(hex: "#EBEAEB"),
            100: Color(hex: "#D6D5D8"),
            200: Color(hex: "#AEACB0"),
            300: Color(hex: "#858289"),
            400: Color(hex: "#5D5861"),
            500: Color(hex: "#342F3A"),
            600: Color(hex: "#2A252E"),
            700: Color(hex: "#1F1C23"),
            800: Color(hex: "#151317"),
            900: Color(hex: "#0A090C")
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
    
    struct ThemePalette {
            let primary: Color
            var secondary: Color { primary.opacity(0.72) }
            var tertiary: Color { primary.opacity(0.48) }
            var quarternary: Color { primary.opacity(0.32) }

            subscript(key: String) -> Color {
                switch key {
                case "primary": return primary
                case "secondary": return secondary
                case "tertiary": return tertiary
                case "quarternary": return quarternary
                default: return .black
                    
                }
            }
        }
    
    struct Palette_text_color {
        let white = ThemePalette(
            primary: Color(hex: "#FFFFFF")
        )
        
        let black = ThemePalette(
            primary: Color(hex: "#020303")
        )
    }
    
    struct Palette_text {
        private let named: [String: Color] = [
            "primary": Color(hex: "#020303"),
            "secondary": Color(hex: "#464C53"),
            "tertiary": Color(hex: "#777F88"),
            "quarternary": Color(hex: "#AFB2B6")
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
    static let b = Palette_b()
    static let s = Palette_s()
    static let txtop = Palette_text_color()
    static let txt = Palette_text()
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
