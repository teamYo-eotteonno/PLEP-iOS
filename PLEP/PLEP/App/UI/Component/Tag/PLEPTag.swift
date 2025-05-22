//
//  PLEPTag.swift
//  PLEP
//
//  Created by 이다경 on 5/21/25.
//

import SwiftUI

struct PLEPTag: View {
    let title: String
    let type: PLEPTagType
    let size: PLEPTagSize
    let enabled: Bool

    var body: some View {
        Text(title)
            .padding(.horizontal, style.width)
            .textStyle(style.textStyle)
            .frame(minHeight: style.height)
            .foregroundColor(style.textColor)
            .background(style.backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(style.borderColor, lineWidth: style.borderWidth)
            )
            .cornerRadius(25)
    }

    private var style: PLEPTagStyle {
        PLEPTagStyle(type: type, size: size, enabled: enabled)
    }
}
