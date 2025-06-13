//
//  ScheduleList.swift
//  PLEP
//
//  Created by 이다경 on 6/12/25.
//

import SwiftUI

struct ScheduleList: View {
    @State var isExpanded: Bool = false
    let null: Bool
    var body: some View {
        VStack(spacing: 0) {
            ScheduleCellHeader(size: .small, num: 1, isExpanded: $isExpanded)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isExpanded.toggle()
                    }
                }
            if !isExpanded {
                if !null {
                    VStack(spacing: 10) {
                        ForEach(0..<4) { _ in
                            VStack(spacing: 0) {
                                ScheduleCellBody(
                                    place: "방탄소년단",
                                    address: "빅히트본사",
                                    touch: false
                                )
                                Rectangle()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 1)
                                    .foregroundColor(.g[200])
                            }
                        }
                        ScheduleCellBody(
                            place: "방탄소년단",
                            address: "빅히트본사",
                            touch: false
                        )
                    }
                    .padding(.top, 10)
                    .transition(.move(edge: .top).combined(with: .opacity))
                } else {
                    VStack(spacing: 10) {
                        Image(Asset.Calendar.add)
                            .frame(width: 40, height: 40)
                        Text("현재 스케쥴이 없습니다!\n스케쥴을 추가해서 성공적인 여행을 즐겨보세요!")
                            .textStyle.body.small
                            .foregroundColor(.txt.primary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 70)
                    .background(Color.g[0])
                    .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
        }
        .cornerRadius(10)
        .animation(.easeInOut(duration: 0.3), value: isExpanded)
    }
}

#Preview {
    ScheduleList(null: true)
}
