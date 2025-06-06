//
//  JoinFourthView.swift
//  PLEP
//
//  Created by 이다경 on 5/4/25.
//

import SwiftUI

struct JoinFourthView: View {
    @State private var next: Bool = false
    @Environment(\.dismiss) private var dismiss
    @State private var randomType: ProfileCellType = .way
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.g[0].ignoresSafeArea()
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
                        ProfileCell(type: randomType)
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
                        next = true
                    }
                    .padding(.bottom, 65)
                    
                    NavigationLink(destination: JoinFifthView(), isActive: $next) {
                        EmptyView()
                    }
                }
                .padding(.horizontal, 25)
                .padding(.top)
            }
        }
        .toolbar {
            PLEPToolbar { dismiss() }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    JoinFourthView()
}
