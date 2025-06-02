//
//  SearchingPopCell.swift
//  PLEP
//
//  Created by 이다경 on 6/1/25.
//

import SwiftUI

struct SearchingPopCell: View {
    @Binding var search: String
    
    var body: some View {
        VStack(spacing: 15) {
            VStack(spacing: 0) {
                Text("원하는 위치를 작성해주세요!")
                    .textStyle.title.subtitle
                    .foregroundColor(.txt.primary)
                Text("AI가 여러분이 좋아할만한 위치를 분석해")
                    .textStyle.body.default
                    .foregroundColor(.txt.secondary)
                Text("추천해드립니다.")
                    .textStyle.body.default
                    .foregroundColor(.txt.secondary)
            }
            
            VStack(alignment: .trailing, spacing: 5) {
                PLEPTextField(
                    text: $search,
                    placeholder: "위치를 작성해주세요",
                    isSecure: false,
                    validate: { !$0.isEmpty },
                    errorMessage: "위치를 작성해주세요"
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
