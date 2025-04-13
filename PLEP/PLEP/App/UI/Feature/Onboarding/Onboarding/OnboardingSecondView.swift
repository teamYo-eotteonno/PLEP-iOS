//
//  OnboardingSecondView.swift
//  PLEP
//
//  Created by 이다경 on 4/10/25.
//

import SwiftUI

struct OnboardingSecondView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var join: Bool = false
    @State private var login: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.b[500].ignoresSafeArea()
                VStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(Asset.Join.first)
                                .resizable()
                                .frame(width: 60, height: 60)
                            Spacer()
                        }
                        Text("플렙 계정이 이미 있나요?")
                            .textStyle(TextStyle.title1.bold)
                            .foregroundColor(.txtop.white.primary)
                    }
                    Spacer()
                        .frame(height: 200)
                    HStack(spacing: 0) {
                        Spacer()
                        Image(Asset.Character.way)
                            .offset(x: 55)
                        Image(Asset.Character.loke)
                    }
                    Spacer()
                        .frame(height: 100)
                    VStack(spacing: 15) {
                        PLEPButton(
                            title: "네",
                            type: .filled,
                            size: .medium,
                            enabled: true,
                            color: .dark,
                            icon: false
                        ) {
                            login = true
                        }
                        PLEPButton(
                            title: "아니요",
                            type: .neutral,
                            size: .medium,
                            enabled: true,
                            color: .purple,
                            icon: false
                        ) {
                            join = true
                        }
                    }
                    NavigationLink(destination: JoinFirstView(), isActive: $join) {
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
    OnboardingSecondView()
}
