//
//  JoinFifthView.swift
//  PLEP
//
//  Created by 이다경 on 5/9/25.
//

import SwiftUI
import FlowKit

struct JoinFifthView: View {
    @Flow var flow
    @State private var introduce = ""
    
    @ObservedObject var viewModel: JoinViewModel
    var joinViewDi: JoinViewDi
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        ZStack {
            Color.g[0].ignoresSafeArea()
            VStack(spacing: 0) {
                PLEPTopbar(type: .default, action: { flow.pop() }, showLine: false)
                VStack {
                    VStack(alignment: .leading) {
                        Text("자기소개를 작성해주세요.")
                            .textStyle.title.header3
                            .foregroundColor(.txt.primary)
                            .padding(.bottom, 1)
                        Text("(작성 없이 넘어갈 수 있는 항목입니다.)")
                            .textStyle.body.default
                            .foregroundColor(.txt.primary)
                            .padding(.bottom, 25)
                        PLEPTextField(
                            text: $introduce,
                            placeholder: "개성 넘치는 자기소개를 부탁해요!",
                            errorMessage: ""
                        )
                    }
                    Spacer()
                    PLEPButton(
                        title: "넘어가기",
                        type: .neutral,
                        size: .medium,
                        enabled: true
                    ) {
                        viewModel.updateIntro(introduce)
                        print(viewModel.joinData.value)
                        
                        let data = viewModel.joinData.value
                        
                        viewModel.join(
                                email: data.email,
                                password: data.pass,
                                name: data.name,
                                bio: data.intro,
                                code: data.code,
                                photo: data.photo
                        )
                    }
                    .padding(.bottom, 65)
                }
                .padding(.horizontal, 25)
                .padding(.top)
            }
        }
        .navigationBarHidden(true)
        .onReceive(viewModel.$joinResult.compactMap { $0 }) { result in
            if result {
                flow.push(JoinSixthView())
            } else {
                self.alertMessage = viewModel.errorMessage ?? "회원가입에 실패했습니다."
                self.showAlert = true
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("회원가입 실패"),
                message: Text(alertMessage),
                dismissButton: .default(Text("확인"))
            )
        }
    }
}
