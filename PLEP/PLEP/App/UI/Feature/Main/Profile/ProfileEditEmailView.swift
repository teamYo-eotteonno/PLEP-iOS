//
//  ProfileEditEmailView.swift
//  PLEP
//
//  Created by 이다경 on 6/6/25.
//

import SwiftUI
import FlowKit

struct ProfileEditEmailView: View {
    @Flow var flow
    @State private var newEmail = ""
    @State private var inputs = Array(repeating: 0, count: 6)
    
    var body: some View {
        ZStack {
            Color.g[50].ignoresSafeArea()
            VStack(spacing: 0) {
                PLEPTopbar(type: .text("이메일 변경"), action: { flow.pop() })
                
                VStack {
                    VStack(spacing: 70) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("이메일")
                                .textStyle.body.bold
                                .foregroundColor(.txt.primary)
                            
                            HStack(spacing: 5) {
                                PLEPTextField(
                                    text: $newEmail,
                                    placeholder: "새로운 이메일을 입력해주세요",
                                    errorMessage: "새로운 이메일을 입력해주세요"
                                )
                                PLEPButton(
                                    title: "인증받기",
                                    type: .filled,
                                    size: .small,
                                    enabled: newEmail.isEmpty ? false : true,
                                    action: {}
                                )
                                .frame(width: 80)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("이메일 인증 번호 작성")
                                .textStyle.body.bold
                                .foregroundColor(.txt.primary)
                            
                            PLEPSingleTextFieldGroup(inputs: $inputs, limit: 300)
                            
                            PLEPButton(
                                title: "이메일 다시 전송 받기",
                                type: .neutral,
                                size: .small,
                                enabled: true,
                                action: {}
                            )
                            .frame(width: 176)
                        }
                    }
                    
                    Spacer()
                    
                    PLEPButton(
                        title: "변경완료",
                        type: .neutral,
                        size: .small,
                        enabled: true,
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
    ProfileEditEmailView()
}
