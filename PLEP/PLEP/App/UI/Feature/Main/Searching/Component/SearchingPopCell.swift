//
//  SearchingPopCell.swift
//  PLEP
//
//  Created by 이다경 on 6/1/25.
//

import SwiftUI

struct SearchingPopCell: View {
    @State private var search = ""
    
    var body: some View {
        VStack(spacing: 15) {
            VStack(spacing: 0) {
                Text("원하는 위치를 작성해주세요!")
                    .textStyle.title.subtitle
                    .foregroundColor(.txt.primary)
                Text("AI가 여러분이 좋아할만한 위치를 분석해 추천해드립니다.")
                    .textStyle.body.default
                    .foregroundColor(.txt.secondary)
            }
            VStack(alignment: .trailing) {
                PLEPTextField(
                    text: $search,
                    placeholder: "장소를 재검색 해주세요.",
                    isSecure: false,
                    validate: { !$0.isEmpty },
                    errorMessage: "닉네임을 입력해주세요",
                    icon: false
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
        }
        .padding(.vertical, 25)
        .padding(.horizontal, 20)
    }
}

#Preview {
    SearchingPopCell()
}
