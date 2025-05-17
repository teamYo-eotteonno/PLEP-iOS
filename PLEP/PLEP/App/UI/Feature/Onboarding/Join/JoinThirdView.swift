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
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.b[500].ignoresSafeArea()
                VStack {
                    VStack(spacing: 25) {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(Asset.Join.email)
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                Spacer()
                            }
                            Text("이메일을 입력해주세요.")
                                .textStyle(TextStyle.title2.bold)
                                .foregroundColor(.txtop.white.primary)
                        }
                        HStack(alignment: .top) {
                            PLEPTextField(
                                text: $email,
                                placeholder: "mail를 입력해주세요.",
                                color: .gray,
                                login: false,
                                isSecure: false,
                                validate: { !$0.isEmpty },
                                errorMessage: "mail를 입력해주세요"
                            )
                            .textInputAutocapitalization(.never)
                            Text("@")
                                .textStyle(TextStyle.body.default)
                                .foregroundColor(.txtop.white.primary)
                                .padding(.top, 12)
                            
                            if selected == "기타" {
                                PLEPTextField(
                                    text: $lastmail,
                                    placeholder: "직접입력",
                                    color: .gray,
                                    login: false,
                                    isSecure: false,
                                    validate: { !$0.isEmpty },
                                    errorMessage: "도메인을 입력해주세요"
                                )
                                .textInputAutocapitalization(.never)
                                .frame(width: 144)
                            } else {
                                PLEPDropdown(
                                    title: "naver.com",
                                    options: ["gmail.com", "kakao.com", "기타"],
                                    selection: $selected,
                                    type: .dark
                                )
                                .frame(width: 144)
                            }
                        }
                    }
                    Spacer()
                    PLEPButton(
                        title: "넘어가기",
                        type: .filled,
                        size: .medium,
                        enabled: email.isEmpty ? false : true,
                        color: .purple,
                        icon: false
                    ) {
                        next = true
                    }
                    .padding(.bottom, 65)
                    
                    NavigationLink(destination: JoinFourthView(), isActive: $next) {
                        EmptyView()
                    }
                }
                .padding(.horizontal, 30)
                .padding(.top)
            }
        }
        .toolbar {
            PLEPToolbarBackButton {
                    dismiss()
                }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    JoinThirdView()
}
