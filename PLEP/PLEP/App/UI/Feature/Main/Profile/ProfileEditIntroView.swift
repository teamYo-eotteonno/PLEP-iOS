//
//  ProfileEditIntroView.swift
//  PLEP
//
//  Created by 이다경 on 6/6/25.
//

import SwiftUI
import FlowKit

struct ProfileEditIntroView: View {
    @Flow var flow
    @State private var newIntro = ""
    var nowIntro: String
    
    var body: some View {
        ZStack {
            Color.g[50].ignoresSafeArea()
            VStack(spacing: 0) {
                PLEPTopbar(type: .text("자기소개글 변경"), action: { flow.pop() })
                
                VStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("자기소개글")
                            .textStyle.body.bold
                            .foregroundColor(.txt.primary)
                        
                        PLEPTextField(
                            text: $newIntro,
                            placeholder: nowIntro,
                            errorMessage: "닉네임을 입력해 주세요",
                            intro: true
                        )
                        .frame(height: 214)
                    }
                    
                    Spacer()
                    
                    PLEPButton(
                        title: "변경완료",
                        type: .neutral,
                        size: .small,
                        enabled: newIntro.isEmpty ? false : true,
                        action: {}
                    )
                }
                .padding(.horizontal, 25)
                .padding(.top, 33)
                .padding(.bottom, 64)
            }
            Spacer()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ProfileEditIntroView(nowIntro: "안녕하세요 저는 방탄소년단 황금막내 전정국입니다")
}
