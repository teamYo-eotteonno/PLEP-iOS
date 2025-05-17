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
                Color.b[500].ignoresSafeArea()
                VStack {
                    VStack(spacing: 25) {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(Asset.Join.pass)
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                Spacer()
                            }
                            Text("비밀번호를 입력해주세요.")
                                .textStyle(TextStyle.title2.bold)
                                .foregroundColor(.txtop.white.primary)
                        }
                        PLEPTextField(
                            text: $pass,
                            placeholder: "PW를 입력해주세요.",
                            color: .gray,
                            login: false,
                            isSecure: true,
                            validate: { !$0.isEmpty },
                            errorMessage: "PW를 입력해주세요"
                        )
                        if !pass.isEmpty {
                            PLEPTextField(
                                text: $passcheck,
                                placeholder: "PW를 다시 입력해주세요.",
                                color: .gray,
                                login: false,
                                isSecure: true,
                                validate: { !$0.isEmpty },
                                errorMessage: "PW를 다시 입력해주세요"
                            )
                        }
                    }
                    Spacer()
                    PLEPButton(
                        title: "넘어가기",
                        type: .filled,
                        size: .medium,
                        enabled: passcheck.isEmpty ? false : true,
                        color: .purple,
                        icon: false
                    ) {
                        next = true
                    }
                    .padding(.bottom, 65)
                    
                    NavigationLink(destination: JoinThirdView(), isActive: $next) {
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
    JoinSecondView()
}

