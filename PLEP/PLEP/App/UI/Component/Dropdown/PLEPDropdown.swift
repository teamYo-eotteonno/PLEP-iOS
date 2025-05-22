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

    var body: some View {
        VStack(spacing: isExpanded ? -20 : 0) {
            PLEPDropdownHeader(
                title: selection.isEmpty ? title : selection,
                isExpanded: $isExpanded
            )
            .zIndex(1)
            if isExpanded {
                VStack(spacing: 0) {
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .frame(height: 20)
                        .foregroundColor(.g[0])
                    ForEach(options.indices, id: \.self) { index in
                        let isLast = index == options.count - 1
                        
                        Button(action: {
                            withAnimation {
                                selection = options[index]
                                isExpanded = false
                            }
                        }) {
                            Text(options[index])
                                .textStyle.body.small
                                .foregroundColor(.txt.primary)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 18)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.g[0])
                        }
                        Rectangle()
                            .foregroundColor(Color.g[50])
                            .frame(height: 1)
                            .frame(maxWidth: .infinity)
                    }
                }
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.g[50], lineWidth: 1)
                )
                .zIndex(0)
            }
        }
    }
}

#Preview {
    DropdownTestView()
}
