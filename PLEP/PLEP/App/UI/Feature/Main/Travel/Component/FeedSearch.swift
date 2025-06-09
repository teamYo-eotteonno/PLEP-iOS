//
//  FeedSearch.swift
//  PLEP
//
//  Created by 이다경 on 6/8/25.
//

import SwiftUI

struct FeedSearch: View {
    @Binding var search: String
    
    var body: some View {
        VStack(spacing: 5) {
            VStack(alignment: .trailing, spacing: 5) {
                PLEPTextField(
                    text: $search,
                    placeholder: "장소를 재검색 해주세요.",
                    isSecure: false,
                    validate: { !$0.isEmpty },
                    errorMessage: "닉네임을 입력해주세요",
                    icon_t: true
                )
                HStack(spacing: 3) {
                    Image(Asset.gps)
                        .resizable()
                        .frame(width: 15, height: 15)
                    Text("현재 내 위치로 찾기")
                        .textStyle.title.pre
                        .foregroundColor(.txt.quartemary)
                }
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    ForEach(0..<7) { _ in
                        PLEPTag(
                            title: "💜ARMY",
                            type: .outlined,
                            size: .small,
                            enabled: true
                        )
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(Color.g[0])
    }
}
