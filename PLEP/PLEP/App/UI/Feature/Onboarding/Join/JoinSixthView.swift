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
                Color.b[500].ignoresSafeArea()
                VStack {
                    VStack(spacing: 25) {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(Asset.Join.profile)
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                Spacer()
                            }
                            Text("자기소개를 작성해주세요.")
                                .textStyle(TextStyle.title2.bold)
                                .padding(.bottom, 1)
                            Text("바로 넘어갈 수 있는 항목입니다.")
                                .textStyle(TextStyle.caption1.default)
                        }
                        .foregroundColor(.txtop.white.primary)
                        PLEPTextField(
                            text: $introduce,
                            placeholder: "개성 넘치는 자기소개를 부탁해요!",
                            color: .gray,
                            login: false,
                            errorMessage: ""
                        )
                    }
                    Spacer()
                    Spacer()
                    PLEPButton(
                        title: "넘어가기",
                        type: .filled,
                        size: .medium,
                        enabled: true,
                        color: .purple,
                        icon: false
                    ) {
                        next = true
                    }
                    .padding(.bottom, 65)
                    
                    NavigationLink(destination: JoinSeventhView(), isActive: $next) {
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
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    JoinSixthView()
}
