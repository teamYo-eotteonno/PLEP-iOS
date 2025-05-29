//
//  JoinFirstView.swift
//  PLEP
//
//  Created by 이다경 on 4/12/25.
//

import SwiftUI

struct JoinFirstView: View {
    @State private var next: Bool = false
    @State private var name = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.g[0].ignoresSafeArea()
                VStack {
                    VStack(alignment: .leading, spacing: 25) {
                        Text("닉네임을 입력해주세요.")
                            .textStyle.title.header3
                            .foregroundColor(.txt.primary)
                        PLEPTextField(
                            text: $name,
                            placeholder: "닉네임을 입력해주세요.",
                            isSecure: false,
                            validate: { !$0.isEmpty },
                            errorMessage: "닉네임을 입력해주세요"
                        )
                    }
                    Spacer()
                    PLEPButton(
                        title: "넘어가기",
                        type: .neutral,
                        size: .medium,
                        enabled: name.isEmpty ? false : true,
                        icon: false
                    ) {
                        next = true
                    }
                    .padding(.bottom, 65)
                    
                    NavigationLink(destination: JoinSecondView(), isActive: $next) {
                        EmptyView()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top)
            }
        }
        .toolbar {
            PLEPToolbarBackButton { dismiss() }
        }
        .navigationBarBackButtonHidden()
    }
}


#Preview {
    JoinFirstView()
}
