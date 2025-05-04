//
//  LoginView.swift
//  PLEP
//
//  Created by 이다경 on 5/4/25.
//

import SwiftUI

struct LoginFirstView: View {
    @State private var next: Bool = false
    @State private var id = ""
    @State private var pass = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.b[500].ignoresSafeArea()
                VStack {
                    Spacer()
                    Image(Asset.Logo.light)
                        PLEPTextField(
                            text: $id,
                            placeholder: "ID를 입력해주세요.",
                            color: .gray,
                            login: true,
                            isSecure: false,
                            validate: { !$0.isEmpty },
                            errorMessage: "ID를 입력해주세요"
                        )
                    PLEPTextField(
                        text: $pass,
                        placeholder: "PW를 입력해주세요.",
                        color: .gray,
                        login: true,
                        isSecure: true,
                        validate: { !$0.isEmpty },
                        errorMessage: "PW를 입력해주세요"
                    )
                    Spacer()
                    PLEPButton(
                        title: "로그인",
                        type: .filled,
                        size: .medium,
                        enabled: id.isEmpty || pass.isEmpty ? false : true,
                        color: .purple,
                        icon: false
                    ) {
                        next = true
                    }
                    .padding(.bottom, 65)
                    
                    NavigationLink(destination: JoinSecondView(), isActive: $next) {
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
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LoginFirstView()
}
