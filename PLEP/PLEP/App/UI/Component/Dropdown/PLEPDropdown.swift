//
//  PLEPDropdown.swift
//  PLEP
//
//  Created by 이다경 on 5/8/25.
//

import SwiftUI

struct PLEPDropdown: View {
    let options: [String]
    @Binding var selection: String
    let type: PLEPDropdownType

    @State private var isExpanded = false

    private var style: PLEPDropdownStyle {
        PLEPDropdownStyle(type: type)
    }

    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(selection.isEmpty ? "선택하세요" : selection)
                        .textStyle(TextStyle.caption1.default)
                        .foregroundColor(style.titletextColor)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(style.titletextColor)
                }
                .padding(.vertical)
                .padding(.horizontal, 18)
                .background(style.textbackColor)
                .cornerRadius(8)
            }

            if isExpanded {
                VStack(spacing: 0) {
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
                        .cornerRadius(
                            isLast ? 8 : 0,
                            corners: isLast ? [.bottomLeft, .bottomRight] : []
                        )
                    }
                }
            }
        }
    }
}
