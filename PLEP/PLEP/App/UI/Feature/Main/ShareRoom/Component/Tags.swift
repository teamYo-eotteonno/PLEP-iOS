//
//  Tags.swift
//  PLEP
//
//  Created by 이다경 on 6/3/25.
//

import SwiftUI

struct Tags: View {
    @State private var tagStates: [[Bool]] = Array(
        repeating: Array(repeating: false, count: 3),
        count: 3
    )

    var body: some View {
        VStack(spacing: 15) {
            ForEach(0..<3, id: \.self) { row in
                HStack(spacing: 3) {
                    ForEach(0..<3, id: \.self) { col in
                        Button(action: {
                            tagStates[row][col].toggle()
                        }) {
                            PLEPTag(
                                title: "💜ARMY",
                                type: .outlined,
                                size: .small,
                                enabled: tagStates[row][col]
                            )
                        }
                    }
                }
            }
        }
    }
}
