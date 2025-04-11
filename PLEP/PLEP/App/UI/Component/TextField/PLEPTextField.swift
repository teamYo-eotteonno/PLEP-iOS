//
//  PLEPTextField.swift
//  PLEP
//
//  Created by 이다경 on 4/11/25.
//

import SwiftUI

struct PLEPTextField: View {
    let title: String
    let type: PLEPTextFieldType
    let color: PLEPTextFieldColor
    let icon: Bool

    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity, maxHeight: 48)
                .textStyle(TextStyle.body.default)
                .foregroundColor(style.textColor)
                .background(style.backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(style.borderColor, lineWidth: 1)
                )
                .cornerRadius(10)
        }
    }

    private var style: PLEPTextFieldStyle {
        PLEPTextFieldStyle(color: color, type: type, login: false)
    }
}

