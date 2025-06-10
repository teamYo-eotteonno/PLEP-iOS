//
//  ScheduleAddSheet.swift
//  PLEP
//
//  Created by 이다경 on 6/10/25.
//

import SwiftUI

struct ScheduleAddSheet: View {
    @State private var title = ""
    @State private var note = ""
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 17) {
                Text("스케줄 추가")
                    .textStyle.body.bold
                    .foregroundColor(.txt.primary)
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)
                    .foregroundColor(.g[200])
            }
            
            VStack(spacing: 15) {
                PLEPTextField(
                    text: $title,
                    placeholder: "제목",
                    errorMessage: "제목을 입력해주세요"
                )
                
                PLEPButton(
                    title: "위치 추가",
                    type: .neutral,
                    size: .small,
                    enabled: true,
                    icon: Asset.Address.default,
                    action: {}
                )
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Image(Asset.note)
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("메모")
                            .textStyle.body.bold
                            .foregroundColor(.txt.primary)
                    }
                    .padding(10)
                    PLEPTextField(
                        text: $note,
                        placeholder: "메모 내용을 입력해주세요",
                        errorMessage: "메모 내용을 입력해주세요",
                        intro: true
                    )
                }
            }
            
            PLEPButton(
                title: "저장",
                type: .filled,
                size: .small,
                enabled: false,
                action: {}
            )
        }
        .padding(.bottom, 45)
        .padding(.horizontal, 25)
    }
}

#Preview {
    ScheduleAddSheet()
}
