//
//  JoinThirdView.swift
//  PLEP
//
//  Created by 이다경 on 5/4/25.
//

import SwiftUI
import FlowKit

struct JoinThirdView: View {
    @Flow var flow
    @State private var email = ""
    @State private var inputs = Array(repeating: 0, count: 6)
    @State private var emailSubmitted = false
    
    @FocusState private var emailFieldFocused: Bool

    @ObservedObject var viewModel: JoinViewModel
    var joinViewDi: JoinViewDi

    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        ZStack {
            Color.g[0].ignoresSafeArea()
            VStack {
                PLEPTopbar(type: .default, action: { flow.pop() }, showLine: false)
                JoinThirdContentView(
                    email: $email,
                    inputs: $inputs,
                    emailSubmitted: $emailSubmitted,
                    emailFieldFocused: _emailFieldFocused,
                    viewModel: viewModel,
                    joinViewDi: joinViewDi,
                    sendEmailCode: sendEmailCode,
                    isNextButtonEnabled: isNextButtonEnabled
                )
            }
        }
        .onReceive(viewModel.$emailCodeResult.compactMap { $0 }) { _ in
            emailSubmitted = true
        }
        .onReceive(viewModel.$errorMessage.compactMap { $0 }) { msg in
            self.alertMessage = msg
            self.showAlert = true
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("이메일 인증 실패"),
                message: Text(alertMessage),
                dismissButton: .default(Text("확인"))
            )
        }
        .navigationBarHidden(true)
    }

    private func sendEmailCode() {
        viewModel.updateEmail(email)
        viewModel.requestEmailCode()
    }

    var isNextButtonEnabled: Bool {
        if emailSubmitted {
            return inputs.allSatisfy { $0 >= 0 && $0 <= 9 }
        } else {
            return !email.isEmpty
        }
    }
}
