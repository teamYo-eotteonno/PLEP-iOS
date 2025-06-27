//
//  ScheduleAddView.swift
//  PLEP
//
//  Created by 이다경 on 6/16/25.
//

import SwiftUI
import FlowKit

struct ScheduleAddView: View {
    @Flow var flow
    @State private var title: String = ""
    @State private var alarm: Bool = false
    @State private var selection = ""
    
    var body: some View {
        ZStack {
            Color.g[50].ignoresSafeArea()
            VStack(spacing: 0) {
                PLEPTopbar(type: .text("일정 추가"), action: { flow.pop() })
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 23) {
                        PLEPTextField(
                            text: $title,
                            placeholder: "제목을 입력해주세요",
                            errorMessage: "제목을 입력해주세요"
                        )
                        
                        ScheduleDateAndTime()
                        
                        PLEPOption(
                            title: "알람추가",
                            type: .filled,
                            state: alarm ? true : false,
                            action: { alarm.toggle() }
                        )
                        
                        PLEPDropdown(
                            title: "그룹 선택",
                            options: [
                                .file.red : "빨강",
                                .file.green : "초록",
                                .file.lame : "라임",
                                .file.blue : "파랑"
                            ],
                            selection: $selection
                        )
                    }
                    .padding(.top, 30)
                    PLEPButton(
                        title: "저장",
                        type: .filled,
                        size: .small,
                        enabled: false,
                        action: {}
                    )
                    .padding(.top, 100)
                }
                .padding(.horizontal, 25)
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ScheduleAddView()
}
