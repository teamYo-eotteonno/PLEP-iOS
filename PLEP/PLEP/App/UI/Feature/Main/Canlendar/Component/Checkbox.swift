//
//  Checkbox.swift
//  PLEP
//
//  Created by 이다경 on 6/11/25.
//

import SwiftUI

struct Checkbox: View {
//    var text: String
//    var type: SafeCheckCheckBoxColorType
    @Binding var isChecked: Bool

    var body: some View {
        HStack(spacing: 12) {
            Button(action: {
                isChecked.toggle()
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 16, height: 16)
                        .foregroundColor(isChecked ? .p[500] : .clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(isChecked ? Color.p[500] : Color.icon.tertiary, lineWidth: 2)
                        )
                    if isChecked {
                        Image(Asset.check)
                    }
                }
            }
        }
    }
}
