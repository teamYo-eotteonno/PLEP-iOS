//
//  JoinSeventhView.swift
//  PLEP
//
//  Created by 이다경 on 5/17/25.
//

import SwiftUI

struct JoinSeventhView: View {
    @State private var next: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.b[500]
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                        .frame(maxHeight: 150)
                    VStack(spacing: 10) {
                        Text("축하해요!")
                            .textStyle(TextStyle.xlargetitle.bold)
                        HStack(spacing: 5) {
                            Image(Asset.Logo.light)
                                .resizable()
                                .frame(width: 70, height: 20)
                            Text("에 오신 것을 환영해요.")
                                .textStyle(TextStyle.title2.default)
                        }
                    }
                    .foregroundColor(.txtop.white.primary)
                    Spacer()
                    PLEPButton(
                        title: "회원가입 완료",
                        type: .filled,
                        size: .medium,
                        enabled: true,
                        color: .purple,
                        icon: false
                    ) {
                        next = true
                    }
                    .padding(.bottom, 65)
                    NavigationLink(destination: OnboardingSecondView(), isActive: $next) {
                        EmptyView()
                    }
                }
                .padding(.horizontal, 30)
            }
        }
        .navigationBarBackButtonHidden()
    }
}
#Preview {
    JoinSeventhView()
}
