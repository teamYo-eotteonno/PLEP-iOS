//
//  MoreSheet.swift
//  PLEP
//
//  Created by 이다경 on 6/6/25.
//

import SwiftUI

struct MoreSheet: View {
    let onMember: () -> Void
    let onRoom: () -> Void
    
    var body: some View {
        ZStack {
            Color.g[0].ignoresSafeArea()
            VStack(alignment: .leading, spacing: 20) {
                Button(action: { onMember() }) {
                    HStack(spacing: 5) {
                        Image(Asset.User.edit)
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("멤버 목록 수정")
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 7)
                }
                
                Button(action: { onRoom() }) {
                    HStack(spacing: 5) {
                        Image(Asset.roomEdit)
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("룸 정보 수정")
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 7)
                }
            }
            .textStyle.body.default
            .foregroundColor(.txt.tertiary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 41)
            .background(Color.g[0])
        }
    }
}
