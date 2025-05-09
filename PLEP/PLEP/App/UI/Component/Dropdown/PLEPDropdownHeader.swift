//
//  PLEPDropdownHeader.swift
//  PLEP
//
//  Created by 이다경 on 5/9/25.
//

import SwiftUI

struct PLEPDropdownHeader: View {
    let title: String
    @Binding var isExpanded: Bool
    let style: PLEPDropdownStyle

    var body: some View {
        Button(action: {
            withAnimation {
                isExpanded.toggle()
            }
        }) {
            HStack {
                Text(title)
                    .textStyle(TextStyle.caption1.default)
                    .foregroundColor(style.titletextColor)
                Spacer()
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(style.titletextColor)
            }
            .padding(.vertical)
            .padding(.horizontal, 18)
            .background(style.textbackColor)
            .cornerRadius(10)
        }
    }
}

#Preview {
    DropdownTestView()
}
