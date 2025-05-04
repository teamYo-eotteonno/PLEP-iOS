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
                        HStack {
                            PLEPTextField(
                                text: $email,
                                placeholder: "Email를 입력해주세요.",
                                color: .gray,
                                login: false,
                                isSecure: false,
                                validate: { !$0.isEmpty },
                                errorMessage: "Email를 입력해주세요"
                            )
                            Text("@")
                                .textStyle(TextStyle.body.default)
                                .foregroundColor(.txtop.white.primary)
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
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    JoinThirdView()
}
