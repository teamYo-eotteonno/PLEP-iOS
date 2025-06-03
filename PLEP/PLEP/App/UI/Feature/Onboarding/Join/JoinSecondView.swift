//
//  JoinSecondView.swift
//  PLEP
//
//  Created by 이다경 on 5/3/25.
//

import SwiftUI

struct JoinSecondView: View {
    @State private var pass = ""
    @State private var passcheck = ""
    @Environment(\.dismiss) private var dismiss
    @State private var next: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.g[0].ignoresSafeArea()
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
                        next = true
                    }
                    .padding(.bottom, 65)
                    
                    NavigationLink(destination: JoinThirdView(), isActive: $next) {
                        EmptyView()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top)
            }
        }
        .toolbar {
            PLEPToolbar { dismiss() }
        }
        .navigationBarBackButtonHidden()
    }
}


#Preview {
    JoinSecondView()
}

