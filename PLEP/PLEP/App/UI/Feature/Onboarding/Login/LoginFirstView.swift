//
//  LoginView.swift
//  PLEP
//
//  Created by 이다경 on 5/4/25.
//

import SwiftUI
import FlowKit
import RxSwift

struct LoginFirstView: View {
    @Flow var flow
    @State private var email = ""
    @State private var pass = ""
    
    @State private var isSelected = false
    
    @StateObject var viewModel: LoginViewModel
    
    var body: some View {
        ZStack {
            Color.g[0].ignoresSafeArea()
            VStack {
                PLEPTopbar(type: .default, action: { flow.pop() }, showLine: false)
                VStack {
                    Spacer()
                    Text("PLEP")
                        .textStyle.logo
                        .foregroundColor(.txt.primary)
                    VStack(alignment: .leading, spacing: 10) {
                        PLEPTextField(
                            text: $email,
                            placeholder: "이메일을 입력해주세요.",
                            isSecure: false,
                            validate: { !$0.isEmpty },
                            errorMessage: "이메일을 입력해주세요"
                        )
                        PLEPTextField(
                            text: $pass,
                            placeholder: "비밀번호를 입력해주세요.",
                            isSecure: true,
                            validate: { !$0.isEmpty },
                            errorMessage: "비밀번호를 입력해주세요"
                        )
                        PLEPOption(
                            title: "로그인 상태 유지",
                            type: .neutral,
                            state: isSelected,
                            action: {
                                isSelected.toggle()
                            }
                        )
                    }
                    .padding(.bottom, 100)
                    Spacer()
                    PLEPButton(
                        title: "로그인",
                        type: .outlined,
                        size: .medium,
                        enabled: email.isEmpty || pass.isEmpty ? false : true
                    ) {
                        viewModel.login(email: email, password: pass)
                    }
                    .padding(.bottom, 65)
                }
                .padding(.horizontal, 25)
                .padding(.top)
            }
        }
        .onReceive(viewModel.$loginResult.compactMap { $0 }) { _ in
            flow.push(HomeView())
        }
        .navigationBarHidden(true)
    }
}
