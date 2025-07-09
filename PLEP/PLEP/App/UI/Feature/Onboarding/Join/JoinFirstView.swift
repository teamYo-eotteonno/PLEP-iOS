//
//  JoinFirstView.swift
//  PLEP
//
//  Created by 이다경 on 4/12/25.
//

import SwiftUI
import FlowKit
import RxSwift

struct JoinFirstView: View {
    @Flow var flow
    @State private var name = ""
    
    @ObservedObject var viewModel: JoinViewModel
    var joinViewDi: JoinViewDi
    
    var body: some View {
        ZStack {
            Color.g[0].ignoresSafeArea()
            VStack(spacing: 0) {
                PLEPTopbar(type: .default, action: { flow.pop() }, showLine: false)
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
                        enabled: name.isEmpty ? false : true
                    ) {
                        viewModel.updateName(name)
                        flow.push(joinViewDi.secondView(joinViewDi: joinViewDi))
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
