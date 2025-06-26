//
//  JoinSixthView.swift
//  PLEP
//
//  Created by 이다경 on 5/17/25.
//

import SwiftUI
import FlowKit

struct JoinSixthView: View {
    @Flow var flow
    @State private var introduce = ""
    
    var body: some View {
        ZStack {
            Color.g[0].ignoresSafeArea()
            Image(Asset.flag)
                .resizable()
                .frame(height: 408.91)
                .offset(y: -150)
            HStack(alignment: .bottom, spacing: -60){
                Image(Asset.Way.travel)
                    .resizable()
                    .frame(width: 195.93, height: 207)
                    .zIndex(1)
                Image(Asset.Loke.travel)
                    .resizable()
                    .frame(width: 245.38, height: 296)
            }
            .padding(.top, 150)
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
                .padding(.top, 100)
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
                    enabled: true
                ) {
                    flow.push(HomeView())
                }
                .padding(.bottom, 65)
            }
            .padding(.horizontal, 25)
            .frame(width: 400)
            .padding(.top)
        }
        .ignoresSafeArea(.container, edges: .top)
        .navigationBarHidden(true)
    }
}

#Preview {
    JoinSixthView()
}
