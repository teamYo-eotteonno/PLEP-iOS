//
//  JoinSixthView.swift
//  PLEP
//
//  Created by 이다경 on 5/17/25.
//

import SwiftUI

struct JoinSixthView: View {
    @State private var next: Bool = false
    @State private var introduce = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.g[0].ignoresSafeArea()
                VStack {
                    Text("환영해요!")
                        .textStyle.end
                        .foregroundColor(.txt.primary)
                    Spacer()
                    Text("플렙에서 새로운 여행을")
                        .textStyle.title.header3
                        .foregroundColor(.txt.primary)
                    Text("해봅시다!")
                        .textStyle.title.header3
                        .foregroundColor(.txt.primary)
                    PLEPButton(
                        title: "넘어가기",
                        type: .filled,
                        size: .medium,
                        enabled: true,
                        icon: false
                    ) {
                        next = true
                    }
                    .padding(.bottom, 65)
                    
                    NavigationLink(destination: OnboardingFirstView(), isActive: $next) {
                        EmptyView()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    JoinSixthView()
}
