//
//  MemberList.swift
//  PLEP
//
//  Created by 이다경 on 6/2/25.
//

import SwiftUI

struct MemberList: View {
    let num: Int
    
    var body: some View {
        VStack(spacing: 5) {
            MemberListCell(
                name: "이다경",
                description: "방탄소년단을 \"상남자\"때부터 좋아해왔다가 휴덕하다가 후회하고 돌아온 아미",
                me: true
            )
            ForEach(1..<num) { _ in
                MemberListCell(
                    name: "김태형",
                    description: "방탄소년단에서 막내라인에 속하며 저음이 가장어울리고 세계에서 가장 잘생긴 남자 1위로 선정된 곰도리",
                    me: false,
                    action: {}
                )
            }
            Button(action: {}) {
                HStack(spacing: 3) {
                    Image(Asset.User.Add.default)
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("멤버추가")
                        .textStyle.button.bold
                        .foregroundColor(.icon.tertiary)
                }
                .padding(.vertical, 10)
            }
        }
        .padding(.all, 10)
        .background(Color.g[100])
        .cornerRadius(15)
    }
}
