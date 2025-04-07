//
//  OnboardingView.swift
//  PLEP
//
//  Created by 이다경 on 4/7/25.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.b[500]
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                        .frame(maxHeight: 150)
                    Image(Asset.whitelogo)
                    Spacer()
                    PLEPButton(
                        title: "시작하기",
                        type: .filled,
                        size: .medium,
                        enabled: true,
                        color: .purple,
                        icon: false
                    ) {
                        
                    }
                    .padding(.bottom, 65)
                }
                .padding(.horizontal, 30)
            }
        }
    }
}

#Preview {
    OnboardingView()
}
