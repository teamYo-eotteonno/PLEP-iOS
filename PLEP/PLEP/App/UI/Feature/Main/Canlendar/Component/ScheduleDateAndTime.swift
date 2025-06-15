//
//  ScheduleDateAndTime.swift
//  PLEP
//
//  Created by 이다경 on 6/15/25.
//

import SwiftUI

struct ScheduleDateAndTime: View {
    @State private var startDate: Date?
    @State private var endDate: Date?
    
    @State private var showCalendar = false
    @State private var isSelectingStartDate = false
    @State private var isSelectingEndDate = false
    
    @State private var startTime: String?
    @State private var endTime: String?
    
    @State private var showTime = false
    @State private var isSelectingStartTime = false
    @State private var isSelectingEndTime = false
    
    var body: some View {
        VStack(spacing: 11) {
            HStack(spacing: 23) {
                VStack(spacing: 18) {
                    PLEPButton(
                        title: dateString(from: startDate) ?? "시작일 선택",
                        type: .neutral,
                        size: .small,
                        enabled: true,
                        action: {
                            isSelectingStartDate = true
                            isSelectingEndDate = false
                            showCalendar.toggle()
                        }
                    )
                    PLEPButton(
                        title: "오후 5:00",
                        type: .neutral,
                        size: .small,
                        enabled: true,
                        action: {
                            isSelectingStartTime = true
                            isSelectingEndTime = false
                            showTime.toggle()
                        }
                    )
                }
                
                Image(Asset.Arrow.right)
                    .resizable()
                    .frame(width: 24, height: 24)
                
                VStack(spacing: 18) {
                    PLEPButton(
                        title: dateString(from: endDate) ?? "종료일 선택",
                        type: .neutral,
                        size: .small,
                        enabled: true,
                        action: {
                            isSelectingStartDate = false
                            isSelectingEndDate = true
                            showCalendar.toggle()
                        }
                    )
                    PLEPButton(
                        title: "오후 6:00",
                        type: .neutral,
                        size: .small,
                        enabled: true,
                        action: {
                            isSelectingStartTime = false
                            isSelectingEndTime = true
                            showTime.toggle()
                        }
                    )
                }
            }
            
            if showCalendar {
                MiniCalendar(
                    startDate: $startDate,
                    endDate: $endDate,
                    isSelectingStartDate: isSelectingStartDate,
                    isSelectingEndDate: isSelectingEndDate,
                    onDismiss: {
                        withAnimation {
                            showCalendar = false
                            isSelectingStartDate = false
                            isSelectingEndDate = false
                        }
                    }
                )
            }
            if showTime {
                HStack(spacing: 20) {
                    CharPicker()
                    HStack(spacing: 5) {
                        NumberPicker(range: 1...12)
                        Text(":")
                            .textStyle.title.header3
                            .foregroundColor(.txt.primary)
                        NumberPicker(range: 0...5)
                        NumberPicker(range: 0...9)
                    }
                }
                .padding(.vertical, 20)
            }
        }
    }
    
    private func dateString(from date: Date?) -> String? {
        guard let date = date else { return nil }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "M월 d일 (E)"
        return formatter.string(from: date)
    }
}


#Preview {
    ScheduleDateAndTime()
}
