//
//  OptionTestView.swift
//  PLEP
//
//  Created by 이다경 on 4/13/25.
//

import SwiftUI

struct OptionTestView: View {
    @State private var selectedIndex: Int = 0

    private let options: [(title: String, type: PLEPOptionType)] = [
        ("Filled 옵션", .filled),
        ("Outlined 옵션", .outlined),
        ("Neutral 옵션", .neutral)
    ]

    var body: some View {
        VStack(spacing: 16) {
            ForEach(options.indices, id: \.self) { index in
                PLEPOption(
                    title: options[index].title,
                    type: options[index].type,
                    state: selectedIndex == index,
                    action: {
                        selectedIndex = index
                    }
                )
            }
        }
    }
}

#Preview {
    OptionTestView()
}
