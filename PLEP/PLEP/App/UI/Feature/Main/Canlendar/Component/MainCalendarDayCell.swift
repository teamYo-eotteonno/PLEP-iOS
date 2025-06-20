//
//  CalendarDayCell.swift
//  PLEP
//
//  Created by 이다경 on 6/20/25.
//

import SwiftUI

struct MainCalendarDayCell: View {
    let date: Date
    let calendar: Calendar
    let schedules: [Schedule]
    let selectedDate: Date?
    let tappedDate: Date?
    let onSelect: (Date) -> Void

    var body: some View {
        let isCurrentMonth = calendar.isDate(date, equalTo: calendar.date(from: calendar.dateComponents([.year, .month], from: date))!, toGranularity: .month)
        let isFuture = date > Date()
        let isSelected = selectedDate == date
        let isTapped = tappedDate == date
        let today = calendar.startOfDay(for: Date())
        let cellDate = calendar.startOfDay(for: date)
        let isToday = (cellDate == today)

        let daySchedules = schedules.filter {
            $0.startDate <= date && $0.endDate >= date
        }

        return Button {
            if !isFuture {
                onSelect(date)
            }
        } label: {
            VStack(spacing: 0) {
                // 날짜 숫자
                Text("\(calendar.component(.day, from: date))")
                    .textStyle.body.default
                    .foregroundColor(isToday ? .g[0] : .txt.primary)
                    .frame(maxWidth: .infinity)
                    .background(
                        Circle()
                            .fill(isToday ? Color.p[300] : .clear)
                            .frame(height: 31)
                    )
                
                // 일정 바
                if let schedule = daySchedules.first {
                    let isStart = calendar.isDate(date, inSameDayAs: schedule.startDate)
                    let isEnd = calendar.isDate(date, inSameDayAs: schedule.endDate)
                    
                    let cornerStyle: [UIRectCorner] = {
                        if isStart && isEnd {
                            return [.topLeft, .bottomLeft, .topRight, .bottomRight]
                        } else if isStart {
                            return [.topLeft, .bottomLeft]
                        } else if isEnd {
                            return [.topRight, .bottomRight]
                        } else {
                            return []
                        }
                    }()
                    
                    ZStack {
                        Rectangle()
                            .fill(schedule.color)
                            .cornerRadius(5, corners: cornerStyle)
                            .frame(height: 18)
                            .padding(.leading, isStart ? 2 : 0)
                            .padding(.trailing, isEnd ? 2 : 0)
                        
                        if isStart {
                            Text(schedule.name)
                                .font(.caption2)
                                .foregroundColor(.white)
                                .lineLimit(1)
                                .padding(.horizontal, 4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.top, 10)
                } else {
                    Spacer().frame(height: 18)
                }
                
                Spacer()
            }
            .frame(height: 55.83)
//            .background(Color.red)
        }
//        .disabled(isFuture)
    }
}
