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
    var icon: String?

    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 0) {
                if (icon != nil) {
                    Image(icon!)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(.trailing, 5)
                }
                
                Text(title)
                    .textStyle(style.textStyle)
                    .foregroundColor(style.textColor)
            }
            .frame(maxWidth: .infinity, minHeight: style.height)
            .background(style.backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(style.borderColor, lineWidth: style.borderWidth)
            )
            .cornerRadius(15)
        }
        .disabled(!enabled)
    }

    private var style: PLEPButtonStyle {
        PLEPButtonStyle(type: type, size: size, enabled: enabled)
    }
}
