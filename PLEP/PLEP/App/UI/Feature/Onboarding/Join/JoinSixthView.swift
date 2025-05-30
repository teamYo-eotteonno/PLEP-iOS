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
                Image(Asset.flag)
                    .resizable()
                    .frame(width: 1093.23, height: 408.91)
                    .offset(x: -200, y: -200)
                HStack(alignment: .bottom, spacing: -60){
                    Image(Asset.Way.travel)
                        .resizable()
                        .frame(width: 195.93, height: 207)
                        .zIndex(1)
                    Image(Asset.Loke.travel)
                        .resizable()
                        .frame(width: 245.38, height: 296)
                }
                VStack {
                    VStack(spacing: 13) {
                        HStack {
                            Spacer()
                            Image(Asset.Plane.rise)
                                .resizable()
                                .frame(width: 104.32, height: 86.84)
                        }
                        Text("환영해요!")
                            .textStyle.end
                            .foregroundColor(.txt.primary)
                    }
                    .padding(.top)
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
                .frame(width: 400)
                .padding(.top)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    JoinSixthView()
}
