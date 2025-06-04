//
//  ShareRoomEditTitleView.swift
//  PLEP
//
//  Created by 이다경 on 6/4/25.
//

import SwiftUI

struct ShareRoomEditTitleView: View {
    let title: String
    @State private var newTitle = ""
    
    var body: some View {
        VStack {
            PLEPTopbar(type: .text("방제목 수정"), action: {})
            VStack(spacing: 52) {
//                Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    Text("방제 변경")
                        .textStyle.title.header3
                        .foregroundColor(.txt.primary)
                    PLEPTextField(
                        text: $newTitle,
                        placeholder: title,
                        errorMessage: ""
                    )
                }
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("태그 변경")
                        .textStyle.title.header3
                        .foregroundColor(.txt.primary)
                    VStack(spacing: 25) {
                        ForEach(0..<3) { _ in
                            VStack(alignment: .leading, spacing: 5) {
                                Text("여행 범위")
                                    .textStyle.body.bold
                                    .foregroundColor(.txt.primary)
                                HStack(spacing: 3) {
                                    ForEach (0..<3) { _ in
                                        PLEPTag(
                                            title: "💜ARMY",
                                            type: .outlined,
                                            size: .small,
                                            enabled: false
                                        )
                                    }
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                
                PLEPButton(
                    title: "수정 완료",
                    type: .neutral,
                    size: .small,
                    enabled: true,
                    action: {}
                )
                Spacer()
            }
            .padding(.horizontal, 25)
            .padding(.top, 48)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ShareRoomEditTitleView(title: "아포방포")
}
