//
//  LoginView.swift
//  PLEP
//
//  Created by 이다경 on 5/4/25.
//

import SwiftUI

struct LoginFirstView: View {
    @State private var next: Bool = false
    @State private var name = ""
    @State private var pass = ""
    @Environment(\.dismiss) private var dismiss
    
    @State private var isSelected = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.g[0].ignoresSafeArea()
                VStack {
                    Spacer()
                    VStack(spacing: 50) {
                        Text("PLEP")
                            .textStyle.logo
                            .foregroundColor(.txt.primary)
                        VStack(alignment: .leading, spacing: 10) {
                            PLEPTextField(
                                text: $name,
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
                    }
                    Spacer()
                    PLEPButton(
                        title: "로그인",
                        type: .outlined,
                        size: .medium,
                        enabled: name.isEmpty || pass.isEmpty ? false : true
                    ) {
                        next = true
                    }
                    .padding(.bottom, 65)
                    
                    NavigationLink(destination: JoinSecondView(), isActive: $next) {
                        EmptyView()
                    }
                }
                .padding(.horizontal, 25)
            }
        }
        .toolbar {
            PLEPToolbar { dismiss() }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    LoginFirstView()
}
