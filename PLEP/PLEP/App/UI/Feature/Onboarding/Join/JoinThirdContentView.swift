//
//  JoinThirdContentView.swift
//  PLEP
//
//  Created by 이다경 on 7/11/25.
//

import SwiftUI
import FlowKit

struct JoinThirdContentView: View {
    @Flow var flow
    @Binding var email: String
    @Binding var inputs: [Int]
    @Binding var emailSubmitted: Bool
    
    @FocusState var emailFieldFocused: Bool

    var viewModel: JoinViewModel
    var joinViewDi: JoinViewDi

    var sendEmailCode: () -> Void
    var isNextButtonEnabled: Bool

    var body: some View {
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
                        action: {
                            sendEmailCode()
                        }
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
                    flow.push(JoinFourthView(viewModel: viewModel, joinViewDi: joinViewDi))
                } else {
                    let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
                    let isValid = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
                    
                    if isValid {
                        sendEmailCode()
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
