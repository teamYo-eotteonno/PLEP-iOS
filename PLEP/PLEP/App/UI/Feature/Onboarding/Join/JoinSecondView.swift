//
//  JoinSecondView.swift
//  PLEP
//
//  Created by 이다경 on 5/3/25.
//

import SwiftUI
import FlowKit

struct JoinSecondView: View {
    @Flow var flow
    @State private var pass = ""
    @State private var passcheck = ""
    
    var body: some View {
        ZStack {
            Color.g[0].ignoresSafeArea()
            VStack(spacing: 0) {
                PLEPTopbar(type: .default, action: { flow.pop() }, showLine: false)
                VStack {
                    VStack(alignment: .leading, spacing: 25) {
                        Text("비밀번호를 입력해주세요.")
                            .textStyle.title.header3
                            .foregroundColor(.txt.primary)
                        PLEPTextField(
                            text: $pass,
                            placeholder: "비밀번호를 입력해주세요.",
                            isSecure: true,
                            validate: { !$0.isEmpty },
                            errorMessage: "비밀번호를 입력해주세요"
                        )
                        if !pass.isEmpty {
                            PLEPTextField(
                                text: $passcheck,
                                placeholder: "비밀번호를 다시 입력해주세요.",
                                isSecure: true,
                                validate: { !$0.isEmpty },
                                errorMessage: "비밀번호를 다시 입력해주세요"
                            )
                        }
                    }
                    Spacer()
                    PLEPButton(
                        title: "넘어가기",
                        type: .neutral,
                        size: .medium,
                        enabled: passcheck.isEmpty ? false : true
                    ) {
                        flow.push(JoinThirdView())
                    }
                    .padding(.bottom, 65)
                }
                .padding(.horizontal, 25)
                .padding(.top)
            }
        }
        .navigationBarHidden(true)
    }
}


#Preview {
    JoinSecondView()
}

