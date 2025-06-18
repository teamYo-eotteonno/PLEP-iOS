//
//  ScheduleList.swift
//  PLEP
//
//  Created by 이다경 on 6/12/25.
//

import SwiftUI

struct TimetableList: View {
    @State var isExpanded: Bool = true
    let null: Bool
    let onInformation: () -> Void
    let onAdd: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            TimetableCellHeader(size: isExpanded ? .default : .small, num: 1, isExpanded: $isExpanded)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isExpanded.toggle()
                    }
                }
            if !isExpanded {
                if !null {
                    VStack(spacing: 23) {
                        VStack(spacing: 10) {
                            ForEach(0..<4) { _ in
                                VStack(spacing: 0) {
                                    TimetableCellBody(
                                        place: "방탄소년단",
                                        address: "빅히트본사",
                                        touch: false,
                                        action: onInformation
                                    )
                                    PLEPDivider(type: .g200)
                                }
                            }
                            TimetableCellBody(
                                place: "방탄소년단",
                                address: "빅히트본사",
                                touch: false,
                                action: onInformation
                            )
                        }
                        .padding(.top, 10)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .background(Color.g[0])
                        Button(action: onAdd) {
                            Image(Asset.Add.Rectangle.fill)
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                    }
                } else {
                    VStack(spacing: 10) {
                        Image(Asset.Calendar.add)
                            .frame(width: 40, height: 40)
                        Text("현재 일정이 없습니다!\n일정 추가해서 성공적인 여행을 즐겨보세요!")
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
