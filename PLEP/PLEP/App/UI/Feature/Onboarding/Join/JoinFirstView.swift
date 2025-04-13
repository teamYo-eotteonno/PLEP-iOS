//
//  JoinFirstView.swift
//  PLEP
//
//  Created by 이다경 on 4/12/25.
//

import SwiftUI

struct JoinFirstView: View {
    @State private var id = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.b[500].ignoresSafeArea()
                VStack {
                    VStack(spacing: 25) {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(Asset.Join.id)
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                Spacer()
                            }
                            Text("아이디를 입력해주세요.")
                                .textStyle(TextStyle.title2.bold)
                                .foregroundColor(.txtop.white.primary)
                        }
                        PLEPTextField(
                            text: $id,
                            placeholder: "ID를 입력해주세요.",
                            color: .gray,
                            login: false,
                            isSecure: false,
                            validate: { !$0.isEmpty },
                            errorMessage: "ID를 입력해주세요"
                        )
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
                        
                    }
                    .padding(.bottom, 65)
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
    JoinFirstView()
}
