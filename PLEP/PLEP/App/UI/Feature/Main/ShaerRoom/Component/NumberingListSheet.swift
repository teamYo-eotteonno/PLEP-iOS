//
//  NumberingListSheet.swift
//  PLEP
//
//  Created by 이다경 on 6/3/25.
//

import SwiftUI

struct NumberingListSheet: View {
    let num: Int
    
    var body: some View {
        ZStack {
            Color.g[0]
            
            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        Text("총 ")
                            .foregroundColor(.txt.primary)
                        + Text(String(num))
                            .foregroundColor(.p[500])
                        + Text(" 곳의 장소가 \n저장되었습니다!")
                            .foregroundColor(.txt.primary)
                        
                        Spacer()
                        
                        PLEPButton(
                            title: "PDF로 변환",
                            type: .filled,
                            size: .small,
                            enabled: true,
                            action: {}
                        )
                        .frame(width: 116)
                    }
                    .textStyle.body.small
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text("장소 순서 지정하기")
                            .textStyle.title.header3
                            .foregroundColor(.txt.primary)
                        Text("장소들을 가는 순서에 따라 배치해주세요!")
                            .textStyle.body.default
                            .foregroundColor(.txt.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    NumberingList()
                }
                .padding(.horizontal, 25)
            }
        }
    }
}

#Preview {
    NumberingListSheet(num: 12)
}
