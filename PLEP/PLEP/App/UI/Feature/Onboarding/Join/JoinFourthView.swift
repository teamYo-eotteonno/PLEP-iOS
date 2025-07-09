//
//  JoinFourthView.swift
//  PLEP
//
//  Created by 이다경 on 5/4/25.
//

import SwiftUI
import FlowKit

struct JoinFourthView: View {
    @Flow var flow
    @State private var randomType: ProfileCellType = .way
    
//    @StateObject var viewModel: JoinViewModel
    var joinViewDi: JoinViewDi
    
    var body: some View {
        ZStack {
            Color.g[0].ignoresSafeArea()
            VStack(spacing: 0) {
                PLEPTopbar(type: .default, action: { flow.pop() }, showLine: false)
                VStack(alignment: .leading) {
                    Text("프로필을 설정해주세요.")
                        .textStyle.title.header3
                        .foregroundColor(.txt.primary)
                        .padding(.bottom, 1)
                    Text("(후에 수정이 가능한 항목입니다.)")
                        .textStyle.body.default
                        .foregroundColor(.txt.primary)
                    Spacer()
                    HStack {
                        Spacer()
                        ProfileCell(type: randomType, size: .large, btn: true)
                            .onAppear {
                                randomType = Bool.random() ? .loke : .way
                            }
                        Spacer()
                    }
                    Spacer()
                    PLEPButton(
                        title: "넘어가기",
                        type: .neutral,
                        size: .medium,
                        enabled: true
                    ) {
                        flow.push(joinViewDi.fifthView(joinViewDi: joinViewDi))
                    }
                    .padding(.bottom, 65)
                }
                .padding(.horizontal, 25)
                .padding(.top)
            }
        }
        .navigationBarHidden(true)
    }
}
