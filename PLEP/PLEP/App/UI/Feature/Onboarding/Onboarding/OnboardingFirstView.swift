//
//  OnboardingFirstView.swift
//  PLEP
//
//  Created by 이다경 on 4/10/25.
//

import SwiftUI
import FlowKit

struct OnboardingFirstView: View {
    @Flow var flow
    
    @State private var join: Bool = false
    @State private var login: Bool = false
    
    @State private var joinViewDi = JoinViewDi()
    
    var body: some View {
        ZStack {
            Color.g[0].ignoresSafeArea()
            
            HStack(spacing: -30) {
                Image(Asset.Way.start)
                    .resizable()
                    .frame(width: 358.34, height: 297)
                    .rotationEffect(Angle(degrees: 90))
                    .padding(.leading)
                    .padding(.top, 160)
                VStack(spacing: 40) {
                    Image(Asset.Plane.fall)
                        .resizable()
                        .frame(width: 104.32, height: 86.84)
                        .padding(.trailing, 70)
                    Image(Asset.Loke.start)
                        .resizable()
                        .frame(width: 366.75, height: 417)
                        .rotationEffect(Angle(degrees: -90))
                }
                .padding(.bottom, 120)
            }
            
            VStack {
                VStack(spacing: 10) {
                    Text("PLEP")
                        .textStyle.logo
                    Text("이곳에 온걸 정말 환영해요!")
                        .textStyle.title.subtitle
                    Text("플렙 계정이 이미 있나요?")
                        .textStyle.title.header3
                        .padding(.top, 20)
                }
                .foregroundColor(.txt.primary)
                
                Spacer()
                
                VStack(spacing: 15) {
                    PLEPButton(
                        title: "네",
                        type: .outlined,
                        size: .medium,
                        enabled: true
                    ) {
                        flow.push(LoginViewDi().loginView)
                    }
                    .frame(maxWidth: .infinity)
                    
                    PLEPButton(
                        title: "아니요",
                        type: .neutral,
                        size: .medium,
                        enabled: true
                    ) {
                        flow.push(joinViewDi.firstView(joinViewDi: joinViewDi))
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 25)
                .frame(maxWidth: 400)
                .padding(.bottom, 20)
            }
            .padding(.top, 20)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    OnboardingFirstView()
}
