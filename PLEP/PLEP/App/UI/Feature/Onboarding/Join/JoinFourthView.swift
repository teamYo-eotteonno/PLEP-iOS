//
//  JoinFourthView.swift
//  PLEP
//
//  Created by 이다경 on 5/4/25.
//

import SwiftUI

struct JoinFourthView: View {
    @State private var next: Bool = false
    @Environment(\.dismiss) private var dismiss
    @State private var inputs = Array(repeating: "", count: 6)

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
                        VStack(alignment: .leading, spacing: 10) {
                            Text("이메일 인증 번호 작성")
                                .textStyle(TextStyle.body.default)
                                .foregroundColor(.txtop.white.primary)
                            
                            PLEPSingleTextFieldGroup(inputs: $inputs, limit: 720)
                            
                            PLEPButton(
                                title: "메일 다시 전송 받기",
                                type: .neutral,
                                size: .sSmall,
                                enabled: true,
                                color: .purple,
                                icon: false,
                                action: {}
                            )
                            .frame(width: 124)
                        }
                    }
                    Spacer()
                    PLEPButton(
                        title: "넘어가기",
                        type: .filled,
                        size: .medium,
                        enabled: inputs.allSatisfy { !$0.isEmpty },
                        color: .purple,
                        icon: false,
                        action: {
                            next = true
                        }
                    )
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
    JoinFourthView()
}
