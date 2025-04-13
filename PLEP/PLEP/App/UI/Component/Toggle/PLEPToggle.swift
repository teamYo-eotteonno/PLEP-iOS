//
//  PLEPToggle.swift
//  PLEP
//
//  Created by 이다경 on 4/12/25.
//

import SwiftUI

struct PLEPToggle: View {
    let type: PLEPToggleType
    let enabled: Bool
    let color: PLEPToggleColor

    let action: () -> Void

    private var style: PLEPToggleStyle {
        PLEPToggleStyle(type: type, enabled: enabled, color: color)
    }

    var body: some View {
        Button(action: action) {
            ZStack(alignment: enabled ? .trailing : .leading) {
                RoundedRectangle(cornerRadius: 100)
                    .fill(style.backgroundColor)
                    .frame(width: 50, height: 25)

                Circle()
                    .fill(style.foregroundColor)
                    .frame(width: 22, height: 22)
                    .padding(2)
            }
        }
        .animation(.easeInOut(duration: 0.1), value: enabled)
    }
}
