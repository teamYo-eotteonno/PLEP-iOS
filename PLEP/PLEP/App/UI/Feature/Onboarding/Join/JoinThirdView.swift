//
//  JoinThirdView.swift
//  PLEP
//
//  Created by 이다경 on 5/4/25.
//

import SwiftUI
import FlowKit

struct JoinThirdView: View {
    @Flow var flow
    @State private var email = ""
    @State private var selected = ""
    @State private var lastmail = ""
    @State private var inputs = Array(repeating: 0, count: 6)
    @State private var emailSubmitted = false
    
    @FocusState private var emailFieldFocused: Bool

    @ObservedObject var viewModel: JoinViewModel
    var joinViewDi: JoinViewDi

    var body: some View {
        ZStack {
            Color.g[0].ignoresSafeArea()
            VStack {
                PLEPTopbar(type: .default, action: { flow.pop() }, showLine: false)
                VStack {
                    VStack(alignment: .leading, spacing: 25) {
                        Text("이메일을 입력해주세요.")
                            .textStyle.title.header3
                            .foregroundColor(.txt.primary)
                        
                        PLEPTextField(
                            text: $email,
                            placeholder: "이메일을 입력해주세요.",
                            isSecure: false,
                            validate: { input in
                                guard !input.isEmpty else { return false }
                                let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
                                return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: input)
                            },
                            errorMessage: "잘못된 이메일 형식입니다."
                        )
                        .textInputAutocapitalization(.never)
                        .allowsHitTesting(emailSubmitted ? false : true)
                        .focused($emailFieldFocused)
                    }
                    
                    if emailSubmitted {
                        VStack(alignment: .leading) {
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
                        .padding(.top, 25)
                    }
                    
                    Spacer()
                    
                    PLEPButton(
                        title: "넘어가기",
                        type: .neutral,
                        size: .medium,
                        enabled: isNextButtonEnabled
                    ) {
                        if emailSubmitted {
                            viewModel.updateEmail(email)
                            let codeInt = Int(inputs.map(String.init).joined()) ?? 0
                            viewModel.updateCode(codeInt)
                            flow.push(JoinFourthView(joinViewDi: joinViewDi))
                        } else {
                            let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
                            let isValid = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
                            
                            if isValid {
                                emailSubmitted = true
                            } else {
                                emailFieldFocused = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    emailFieldFocused = false
                                }
                            }
                        }
                    }
                    .padding(.bottom, 65)
                }
                .padding(.horizontal, 25)
                .padding(.top)
            }
        }
        .navigationBarHidden(true)
    }

    var isNextButtonEnabled: Bool {
        if emailSubmitted {
            return inputs.allSatisfy { $0 >= 0 && $0 <= 9 }
        } else {
            return !email.isEmpty
        }
    }
}
