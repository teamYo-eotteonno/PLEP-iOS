//
//  ScheduleDateAndTime.swift
//  PLEP
//
//  Created by 이다경 on 6/15/25.
//

import SwiftUI

struct ScheduleDateAndTime: View {
    @Binding var startDate: Date?
    @Binding var endDate: Date?
    
    @Binding var startTime: String?
    @Binding var endTime: String?
    
    @State private var showCalendar = false
    @State private var isSelectingStartDate = false
    @State private var isSelectingEndDate = false
    
    @State private var showTimeWheel = false
    @State private var isSelectingStartTime = false
    @State private var isSelectingEndTime = false
    
    @State private var startIsPM = false
    @State private var startHour = 1
    @State private var startMinute = 0
    
    @State private var endIsPM = false
    @State private var endHour = 1
    @State private var endMinute = 0
    
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
                            showCalendar = true
                            showTimeWheel = false
                        }
                    )
                    PLEPButton(
                        title: startTime ?? "시작 시간 선택",
                        type: .neutral,
                        size: .small,
                        enabled: true,
                        action: {
                            if showTimeWheel && isSelectingStartTime {
                                showTimeWheel = false
                                isSelectingStartTime = false
                            } else {
                                isSelectingStartTime = true
                                isSelectingEndTime = false
                                showTimeWheel = true
                                showCalendar = false
                            }
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
                            showCalendar = true
                            showTimeWheel = false
                        }
                    )
                    PLEPButton(
                        title: endTime ?? "종료 시간 선택",
                        type: .neutral,
                        size: .small,
                        enabled: true,
                        action: {
                            if showTimeWheel && isSelectingEndTime {
                                showTimeWheel = false
                                isSelectingEndTime = false
                            } else {
                                isSelectingStartTime = false
                                isSelectingEndTime = true
                                showTimeWheel = true
                                showCalendar = false
                            }
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
            
            if showTimeWheel {
                if isSelectingStartTime {
                    TimeWheel(
                        isPM: $startIsPM,
                        hour: $startHour,
                        minute: $startMinute,
                        onTimeChange: { newTime in
                            startTime = newTime
                        }
                    )
                } else if isSelectingEndTime {
                    TimeWheel(
                        isPM: $endIsPM,
                        hour: $endHour,
                        minute: $endMinute,
                        onTimeChange: { newTime in
                            endTime = newTime
                        }
                    )
                }
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
