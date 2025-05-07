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
    
    @State private var isSelected = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.b[500].ignoresSafeArea()
                VStack {
                    Spacer()
                        .frame(height: 130)
                    VStack(spacing: 50) {
                        Image(Asset.Logo.light)
                        VStack(alignment: .leading, spacing: 10) {
                            PLEPTextField(
                                text: $id,
                                placeholder: "ID를 입력해주세요.",
                                color: .gray,
                                login: true,
                                iconName: "person",
                                isSecure: false,
                                validate: { !$0.isEmpty },
                                errorMessage: "ID를 입력해주세요"
                            )
                            PLEPTextField(
                                text: $pass,
                                placeholder: "PW를 입력해주세요.",
                                color: .gray,
                                login: true,
                                iconName: "lock.fill",
                                isSecure: true,
                                validate: { !$0.isEmpty },
                                errorMessage: "PW를 입력해주세요"
                            )
                            PLEPOption(
                                title: "로그인 상태 유지",
                                type: .filled,
                                state: isSelected,
                                action: {
                                    isSelected.toggle()
                                }
                            )
                            .foregroundColor(.txtop.white.primary)
                        }
                    }
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
