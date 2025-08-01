//
//  ShaerRoomCreateView.swift
//  PLEP
//
//  Created by 이다경 on 6/3/25.
//

import SwiftUI
import FlowKit

struct ShareRoomCreateView: View {
    @Flow var flow
    @State private var roomName: String = ""
    var onDismiss: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            Color.g[50].ignoresSafeArea()
            VStack(spacing: 0) {
                PLEPTopbar(
                    type: .default,
                    action: {
                        flow.pop()
                        onDismiss?()
                    }
                )
                Spacer()
                VStack(spacing: 100) {
                    VStack(spacing: 30) {
                        VStack(spacing: 8) {
                            Text("함께 가는 여행!")
                                .textStyle.title.header3
                                .foregroundColor(.txt.primary)
                            Text("어떤 여행")
                                .foregroundColor(.p[500])
                            + Text("을 함께하실 예정인가요?")
                                .foregroundColor(.txt.primary)
                        }
                        .textStyle.body.default
                        PLEPTextField(
                            text: $roomName,
                            placeholder: "방제를 입력해주세요",
                            errorMessage: "방제를 입력해주세요"
                        )
                    }
                    Tags()
                    PLEPButton(
                        title: "룸생성",
                        type: .neutral,
                        size: .small,
                        enabled: true,
                        icon: Asset.User.Users.default,
                        action: {}
                    )
                }
                .padding(.horizontal, 25)
                Spacer()
            }
        }
    }
}
