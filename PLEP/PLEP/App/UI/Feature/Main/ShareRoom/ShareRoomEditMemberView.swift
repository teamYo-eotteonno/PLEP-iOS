//
//  ShareRoomEditMemberView.swift
//  PLEP
//
//  Created by 이다경 on 6/6/25.
//

import SwiftUI

struct ShareRoomEditMemberView: View {
    let num: Int
    @State private var newTitle = ""
    
    var body: some View {
        VStack {
            PLEPTopbar(type: .text("멤버 목록 수정"), action: {})
            ScrollView {
                VStack(alignment: .leading, spacing: 60) {
                    VStack(alignment: .leading, spacing: 20) {
                        HStack(spacing: 10) {
                            Text("멤버 목록")
                                .textStyle.title.header3
                            
                            Capsule()
                                .frame(width: 1, height: 22)
                                .foregroundColor(.g[800])
                            HStack(spacing: 2) {
                                Text("총 인원")
                                    .textStyle.body.default
                                Text(String(num)+"명")
                                    .textStyle.body.bold
                                    .foregroundColor(.p[500])
                            }
                        }
                        .foregroundColor(.txt.primary)
                        MemberList(num: num)
                    }
                    PLEPButton(
                        title: "수정 완료",
                        type: .neutral,
                        size: .small,
                        enabled: true,
                        action: {}
                    )
                    Spacer()
                }
                .padding(.horizontal, 25)
                .padding(.top, 40)
                .background(Color.g[0])
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ShareRoomEditMemberView(num: 4)
}
