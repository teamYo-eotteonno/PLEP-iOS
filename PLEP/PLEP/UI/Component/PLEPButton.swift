//
//  Button.swift
//  PLEP
//
//  Created by 이다경 on 4/3/25.
//

import SwiftUI

// MARK: - PLEPButton View

struct PLEPButton: View {
    let title: String
    let type: PLEPButtonType
    let size: PLEPButtonSize
    let enabled: Bool
    let color: PLEPButtonColor
    let icon: Bool

    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .textStyle(style.textStyle)
                .frame(maxWidth: .infinity, minHeight: style.height)
                .foregroundColor(style.textColor)
                .background(style.backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(style.borderColor, lineWidth: style.borderWidth)
                )
                .cornerRadius(10)
        }
        .disabled(!enabled)
    }

    private var style: PLEPButtonStyle {
        PLEPButtonStyle(type: type, size: size, enabled: enabled, color: color)
    }
}
