//
//  PLEPDropdown.swift
//  PLEP
//
//  Created by 이다경 on 5/8/25.
//

import SwiftUI

struct PLEPDropdown: View {
    let title: String
    let options: [(Color?, String)]
    @Binding var selection: String
    @State private var isExpanded = false

    init(title: String, options: [String], selection: Binding<String>) {
        self.title = title
        self.options = options.map { (nil, $0) }
        self._selection = selection
    }

    init(title: String, options: [Color?: String], selection: Binding<String>) {
        self.title = title
        self.options = options.map { ($0.key, $0.value) }
        self._selection = selection
    }

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
                        let (color, text) = options[index]
                        let isLast = index == options.count - 1
                        
                        Button(action: {
                            withAnimation {
                                selection = text
                                isExpanded = false
                            }
                        }) {
                            HStack(spacing: 10) {
                                if let color = color {
                                    Rectangle()
                                        .fill(color)
                                        .frame(width: 12, height: 12)
                                        .cornerRadius(2)
                                }
                                
                                Text(text)
                                    .textStyle.body.small
                                    .foregroundColor(.txt.primary)
                                
                                Spacer()
                            }
                            .padding(.vertical, 12)
                            .padding(.horizontal, 18)
                            .background(Color.g[0])
                        }
                        
                        if !isLast {
                            PLEPDivider(type: .g50)
                        }
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
