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

    var body: some View {
        Button(action: {
            withAnimation {
                isExpanded.toggle()
            }
        }) {
            HStack {
                Text(title)
                    .textStyle.body.default
                    .foregroundColor(.txt.quartemary)
                Spacer()
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(.icon.tertiary)
            }
            .padding(.vertical)
            .padding(.horizontal, 18)
            .background(Color.g[50])
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.g[50], lineWidth: 1)
            )
        }
    }
}

#Preview {
    DropdownTestView()
}
