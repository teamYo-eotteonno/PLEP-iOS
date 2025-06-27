//
//  ProfileEditFirstView.swift
//  PLEP
//
//  Created by 이다경 on 6/6/25.
//

import SwiftUI
import FlowKit

struct ProfileEditNameView: View {
    @Flow var flow
    @State private var newName = ""
    var nowName: String
    
    var body: some View {
        ZStack {
            Color.g[50].ignoresSafeArea()
            VStack(spacing: 0) {
                PLEPTopbar(type: .text("닉네임 변경"), action: { flow.pop() })
                
                VStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("닉네임")
                            .textStyle.body.bold
                            .foregroundColor(.txt.primary)
                        
                        PLEPTextField(
                            text: $newName,
                            placeholder: "닉네임 입력 (최대 8자)",
                            errorMessage: "닉네임을 입력해 주세요"
                        )
                        
                        Text("현재 닉네임: "+nowName)
                            .textStyle.body.small
                            .foregroundColor(.g[700])
                    }
                    
                    Spacer()
                    
                    PLEPButton(
                        title: "변경완료",
                        type: .neutral,
                        size: .small,
                        enabled: newName.isEmpty ? false : true,
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
    ProfileEditNameView(nowName: "AGUST D")
}
