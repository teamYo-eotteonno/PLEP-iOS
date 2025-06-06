//
//  DeletePopup.swift
//  PLEP
//
//  Created by 이다경 on 6/6/25.
//

import SwiftUI

struct ShareRoomDeletePopup: View {
    var onYes: () -> Void
    var onNo: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 28) {
                    Text("삭제 하시겠습니까?")
                        .textStyle.title.header3
                    
                    Text("룸을 삭제하면 다시 돌아올 수 없습니다.")
                        .textStyle.body.default
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 28)
                .padding(.bottom, 8)
            }
            
            HStack(spacing: 6) {
                PLEPButton(
                    title: "취소",
                    type: .outlined,
                    size: .small,
                    enabled: true,
                    action: { onNo() }
                )
                
                PLEPButton(
                    title: "예",
                    type: .filled,
                    size: .small,
                    enabled: true,
                    action: { onYes() }
                )
            }
            .textStyle.body.bold
            .padding(.bottom, 24)
            .padding(.top, 16)
        }
        .padding(.horizontal, 24)
        .frame(width: 328)
        .background(Color.g[0])
        .cornerRadius(10)
    }
}
