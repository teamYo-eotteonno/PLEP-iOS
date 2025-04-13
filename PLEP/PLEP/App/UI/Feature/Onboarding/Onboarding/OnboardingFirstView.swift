//
//  OnboardingView.swift
//  PLEP
//
//  Created by 이다경 on 4/7/25.
//

import SwiftUI

struct OnboardingFirstView: View {
    @State private var next: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.b[500]
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                        .frame(maxHeight: 150)
                    Image(Asset.Logo.light)
                    Spacer()
                    PLEPButton(
                        title: "시작하기",
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
    }
}

#Preview {
    OnboardingFirstView()
}
