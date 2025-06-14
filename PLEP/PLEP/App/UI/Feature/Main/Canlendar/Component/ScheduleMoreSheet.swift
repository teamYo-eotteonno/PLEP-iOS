//
//  ScheduleMoreSheet.swift
//  PLEP
//
//  Created by 이다경 on 6/10/25.
//

import SwiftUI

struct ScheduleMoreSheet: View {
    let alarm: Bool
    let onDelete: () -> Void
    let onEdit: () -> Void
    let color: Color
    let title: String
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(spacing: 17) {
                HStack {
                    Text("일정 정보")
                        .textStyle.body.bold
                        .foregroundColor(.txt.primary)
                    Spacer()
                    HStack(spacing: 10) {
                        PLEPButton(
                            title: "삭제",
                            type: .neutral,
                            size: .small,
                            enabled: true,
                            action: onDelete
                        )
                        
                        PLEPButton(
                            title: "수정",
                            type: .outlined,
                            size: .small,
                            enabled: true,
                            action: onEdit
                        )
                    }
                    .frame(width: 146)
                }
                PLEPDivider(type: .g200)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 13) {
                        Rectangle()
                            .frame(width: 20, height: 20)
                            .foregroundColor(color)
                            .cornerRadius(5)
                        Text(title)
                            .textStyle.body.bold
                            .foregroundColor(.txt.primary)
                        Spacer()
                    }
                    
                    HStack(spacing: 16) {
                        HStack(spacing: 5) {
                            Image(Asset.clock)
                                .resizable()
                                .frame(width: 18, height: 18)
                            Text("일정 시작 시간")
                                .textStyle.body.bold
                                .foregroundColor(.txt.primary)
                        }
                        Text("17:00")
                            .textStyle.body.default
                            .foregroundColor(.txt.primary)
                    }
                    
                    if alarm {
                        HStack(spacing: 16) {
                            HStack(spacing: 5) {
                                Image(Asset.alarm)
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                Text("알림 시간")
                                    .textStyle.body.bold
                                    .foregroundColor(.txt.primary)
                            }
                            Text("1시간 전 알림")
                                .textStyle.body.default
                                .foregroundColor(.txt.primary)
                        }
                    }
                }
            }
            PLEPButton(
                title: "일정 스케쥴 보기",
                type: .filled,
                size: .small,
                enabled: true,
                action: {}
            )
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 45)
        .padding(.horizontal, 25)
    }
}
