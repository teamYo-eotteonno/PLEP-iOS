//
//  JoinFourthView.swift
//  PLEP
//
//  Created by 이다경 on 5/4/25.
//

import SwiftUI

struct JoinFourthView: View {
    @State private var next: Bool = false
    @State private var one = ""
    @State private var two = ""
    @State private var three = ""
    @State private var four = ""
    @State private var five = ""
    @State private var six = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.b[500].ignoresSafeArea()
                VStack {
                    VStack(spacing: 25) {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(Asset.Join.email)
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                Spacer()
                            }
                            Text("이메일을 입력해주세요.")
                                .textStyle(TextStyle.title2.bold)
                                .foregroundColor(.txtop.white.primary)
                        }
                        VStack(alignment: .leading) {
                            Text("이메일 인증 번호 작성")
                                .textStyle(TextStyle.body.default)
                                .foregroundColor(.txtop.white.primary)
                            HStack {
                                PLEPTextField(
                                    text: $one,
                                    placeholder: "",
                                    color: .gray,
                                    login: false,
                                    isSecure: false,
                                    validate: { !$0.isEmpty },
                                    errorMessage: ""
                                )
                                PLEPTextField(
                                    text: $two,
                                    placeholder: "",
                                    color: .gray,
                                    login: false,
                                    isSecure: false,
                                    validate: { !$0.isEmpty },
                                    errorMessage: ""
                                )
                                PLEPTextField(
                                    text: $three,
                                    placeholder: "",
                                    color: .gray,
                                    login: false,
                                    isSecure: false,
                                    validate: { !$0.isEmpty },
                                    errorMessage: ""
                                )
                                PLEPTextField(
                                    text: $four,
                                    placeholder: "",
                                    color: .gray,
                                    login: false,
                                    isSecure: false,
                                    validate: { !$0.isEmpty },
                                    errorMessage: ""
                                )
                                PLEPTextField(
                                    text: $five,
                                    placeholder: "",
                                    color: .gray,
                                    login: false,
                                    isSecure: false,
                                    validate: { !$0.isEmpty },
                                    errorMessage: ""
                                )
                                PLEPTextField(
                                    text: $six,
                                    placeholder: "",
                                    color: .gray,
                                    login: false,
                                    isSecure: false,
                                    validate: { !$0.isEmpty },
                                    errorMessage: ""
                                )
                            }
                        }
                    }
                    Spacer()
                    PLEPButton(
                        title: "넘어가기",
                        type: .filled,
                        size: .medium,
                        enabled: one.isEmpty || two.isEmpty || three.isEmpty || four.isEmpty || five.isEmpty || six.isEmpty ? false : true,
                        color: .purple,
                        icon: false
                    ) {
                        next = true
                    }
                    .padding(.bottom, 65)
                    
                    NavigationLink(destination: JoinFourthView(), isActive: $next) {
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
    JoinFourthView()
}
