//
//  PLEPDropdown.swift
//  PLEP
//
//  Created by 이다경 on 5/8/25.
//

import SwiftUI

struct PLEPDropdown: View {
    let title: String
    let options: [String]
    @Binding var selection: String
    @State private var isExpanded = false
    let type: PLEPDropdownType

    private var style: PLEPDropdownStyle {
        PLEPDropdownStyle(type: type)
    }

    var body: some View {
        VStack(spacing: isExpanded ? -20 : 0) {
            PLEPDropdownHeader(
                title: selection.isEmpty ? title : selection,
                isExpanded: $isExpanded,
                style: style
            )
            .zIndex(1)
            if isExpanded {
                VStack(spacing: 0) {
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .frame(height: 20)
                        .foregroundColor(style.contentbackColor)
                    ForEach(options.indices, id: \.self) { index in
                        let isLast = index == options.count - 1
                        
                        Button(action: {
                            withAnimation {
                                selection = options[index]
                                isExpanded = false
                            }
                        }) {
                            Text(options[index])
                                .textStyle(TextStyle.caption1.default)
                                .foregroundColor(style.contenttextColor)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 18)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(style.contentbackColor)
                        }
                        Rectangle()
                            .foregroundColor(style.dividerColor)
                            .frame(height: 1)
                            .frame(maxWidth: .infinity)
                    }
                }
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(style.dividerColor, lineWidth: 1)
                )
                .zIndex(0)
            }
        }
    }
}

#Preview {
    DropdownTestView()
}
