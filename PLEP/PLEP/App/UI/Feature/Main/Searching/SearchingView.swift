//
//  SearchingView.swift
//  PLEP
//
//  Created by 이다경 on 6/2/25.
//

import SwiftUI
import FlowKit

struct SearchingView: View {
    @Flow var flow
    @State private var search = ""
    
    var body: some View {
        ZStack {
            Color.g[0].ignoresSafeArea()
            VStack(spacing: 70) {
                SearchingPopCell(search: $search)
                PLEPButton(
                    title: "추천받기",
                    type: .filled,
                    size: .small,
                    enabled: !search.isEmpty,
                    icon: Asset.magic,
                    action: { flow.push(SearchingLoadingView()) }
                )
            }
            .padding(.horizontal, 25)
        }
    }
}

#Preview {
    SearchingView()
}
