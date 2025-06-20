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
    let displayedMonth: Date
    let schedules: [Schedule]
    let selectedDate: Date?
    let tappedDate: Date?
    let onSelect: (Date) -> Void

    var body: some View {
        let isCurrentMonth = calendar.isDate(date, equalTo: displayedMonth, toGranularity: .month)
        let isOtherMonth = !isCurrentMonth
        let today = calendar.startOfDay(for: Date())
        let cellDate = calendar.startOfDay(for: date)
        let isToday = (cellDate == today)

        // 해당 날짜에 걸친 모든 일정
        let daySchedules = schedules.filter {
            $0.startDate <= date && $0.endDate >= date
        }

        return Button {
            onSelect(date)
        } label: {
            VStack(spacing: 0) {
                // 날짜 숫자
                Text("\(calendar.component(.day, from: date))")
                    .textStyle.body.default
                    .foregroundColor(
                        isOtherMonth ? .txt.quartemary :
                        isToday ? .g[0] : .txt.primary
                    )
                    .frame(maxWidth: .infinity)
                    .background(
                        Circle()
                            .fill(isToday ? Color.p[300] : .clear)
                            .frame(height: 31)
                    )

                // 일정 표시
                if daySchedules.count == 1, let schedule = daySchedules.first {
                    let isMultiDay = !calendar.isDate(schedule.startDate, inSameDayAs: schedule.endDate)
                    let isStart = calendar.isDate(date, inSameDayAs: schedule.startDate)
                    let isEnd = calendar.isDate(date, inSameDayAs: schedule.endDate)

                    let cornerStyle: [UIRectCorner] = {
                        if isStart && isEnd {
                            return [.allCorners]
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

                        if isStart || (!isMultiDay && calendar.isDate(date, inSameDayAs: schedule.startDate)) {
                            Text(schedule.name)
                                .font(.caption2)
                                .foregroundColor(.white)
                                .lineLimit(1)
                                .padding(.leading, 6)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.top, 10)

                } else if daySchedules.count > 1 {
                    HStack(spacing: 3) {
                        ForEach(Array(daySchedules.prefix(3).enumerated()), id: \.offset) { _, schedule in
                            Circle()
                                .fill(schedule.color)
                                .frame(width: 6, height: 6)
                        }
                    }
                    .padding(.top, 12)
                    .frame(maxWidth: .infinity)
                } else {
                    Spacer().frame(height: 18)
                }

                Spacer()
            }
            .frame(height: 55.83)
        }
    }
}

#Preview {
    MainCalendar()
}
