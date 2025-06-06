//
//  ProfileEditSecondView.swift
//  PLEP
//
//  Created by 이다경 on 6/6/25.
//

import SwiftUI

struct ProfileEditPWView: View {
    @State private var nowPass = ""
    @State private var newPass = ""
    @State private var newPassCheck = ""
    
    var body: some View {
        VStack(spacing: 0) {
            PLEPTopbar(type: .text("비밀번호 변경"), action: {})
            ZStack {
                Color.g[50]
                
                VStack {
                    VStack(spacing: 25) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("기존 비밀번호")
                                .textStyle.body.bold
                                .foregroundColor(.txt.primary)
                            
                            PLEPTextField(
                                text: $newPass,
                                placeholder: "기존 비밀번호를 입력해주세요",
                                isSecure: true,
                                errorMessage: "기존 비밀번호를 입력해주세요"
                            )
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("변경할 비밀번호")
                                .textStyle.body.bold
                                .foregroundColor(.txt.primary)
                            
                            PLEPTextField(
                                text: $newPass,
                                placeholder: "새 비밀번호를 입력해주세요",
                                isSecure: true,
                                errorMessage: "새 비밀번호를 입력해주세요"
                            )
                            
                            PLEPTextField(
                                text: $newPassCheck,
                                placeholder: "새 비밀번호를 확인해주세요",
                                isSecure: true,
                                errorMessage: "새 비밀번호를 확인해주세요"
                            )
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
        .ignoresSafeArea()
    }
}

#Preview {
    ProfileEditPWView()
}
