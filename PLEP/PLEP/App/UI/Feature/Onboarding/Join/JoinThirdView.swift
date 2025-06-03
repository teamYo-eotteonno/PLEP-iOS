//
//  JoinThirdView.swift
//  PLEP
//
//  Created by 이다경 on 5/4/25.
//

import SwiftUI

struct JoinThirdView: View {
    @State private var next: Bool = false
    @State private var email = ""
    @Environment(\.dismiss) private var dismiss
    @State private var selected = ""
    @State private var lastmail = ""
    @State private var inputs = Array(repeating: "", count: 6)
    @State private var emailSubmitted = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.g[0].ignoresSafeArea()
                VStack {
                    VStack(alignment: .leading, spacing: 25) {
                        Text("이메일을 입력해주세요.")
                            .textStyle.title.header3
                            .foregroundColor(.txt.primary)

                        PLEPTextField(
                            text: $email,
                            placeholder: "이메일을 입력해주세요.",
                            isSecure: false,
                            validate: { !$0.isEmpty },
                            errorMessage: "잘못된 이메일 형식입니다."
                        )
                        .textInputAutocapitalization(.never)
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
                            next = true
                        } else {
                            emailSubmitted = true
                        }
                    }
                    .padding(.bottom, 65)

                    NavigationLink(destination: JoinFourthView(), isActive: $next) {
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

    var isNextButtonEnabled: Bool {
        if emailSubmitted {
            return inputs.allSatisfy { $0.count == 1 }
        } else {
            return !email.isEmpty
        }
    }
}


#Preview {
    JoinThirdView()
}
