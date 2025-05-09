//
//  JoinFifthView.swift
//  PLEP
//
//  Created by 이다경 on 5/9/25.
//

import SwiftUI

struct JoinFifthView: View {
    @State private var next: Bool = false
    @State private var id = ""
    @Environment(\.dismiss) private var dismiss
    @State private var randomType: ProfileCellType = .way
    
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
                            Text("프로필을 설정해주세요.")
                                .textStyle(TextStyle.title2.bold)
                                .foregroundColor(.txtop.white.primary)
                                .padding(.bottom, 1)
                            VStack(alignment: .leading) {
                                Text("후에 수정이 가능한 항목입니다.")
                                Text("(현재 이미지로 설정됩니다.)")
                            }
                            .textStyle(TextStyle.caption1.default)
                            .foregroundColor(.txtop.white.primary)
                        }
                    }
                    Spacer()
                    ProfileCell(type: randomType)
                        .onAppear {
                            randomType = Bool.random() ? .loke : .way
                        }
                    Spacer()
                    PLEPButton(
                        title: "넘어가기",
                        type: .filled,
                        size: .medium,
                        enabled: id.isEmpty ? false : true,
                        color: .purple,
                        icon: false
                    ) {
                        next = true
                    }
                    .padding(.bottom, 65)
                    
                    NavigationLink(destination: JoinSecondView(), isActive: $next) {
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
    JoinFifthView()
}
