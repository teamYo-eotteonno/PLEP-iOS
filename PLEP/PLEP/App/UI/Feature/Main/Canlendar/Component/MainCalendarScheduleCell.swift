//
//  CalendarScheduleCell.swift
//  PLEP
//
//  Created by 이다경 on 6/19/25.
//

import SwiftUI

struct MainCalendarScheduleCell: View {
    let date: Date
    let calendar: Calendar
    let schedules: [Schedule]

    var body: some View {
        let daySchedules = schedules.filter {
            calendar.isDate($0.startDate, inSameDayAs: date) ||
            calendar.isDate($0.endDate, inSameDayAs: date) ||
            ($0.startDate < date && $0.endDate > date)
        }

        Group {
            if daySchedules.count == 1, let schedule = daySchedules.first {
                let isStart = calendar.isDate(date, inSameDayAs: schedule.startDate)
                let isEnd = calendar.isDate(date, inSameDayAs: schedule.endDate)
                let isSingleDaySchedule = calendar.startOfDay(for: schedule.startDate) == calendar.startOfDay(for: schedule.endDate)

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

                if isSingleDaySchedule {
                    // 하루 일정: HStack (사각형 + 텍스트)
                    HStack(spacing: 4) {
                        Rectangle()
                            .fill(schedule.color)
                            .frame(width: 6, height: 6)
                            .cornerRadius(3)
                        Text(schedule.name)
                            .textStyle.title.pre
                            .foregroundColor(.txt.secondary)
                            .lineLimit(1)
                        Spacer()
                    }
//                    .padding(.top, 10)
//                    .padding(.horizontal, 2)
                    .background(Color.green)
                } else {
                    // 장기 일정: 바 형태
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
                                .padding(.leading, 6)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.top, 10)
                }
            } else if daySchedules.count >= 2 {
                // 여러 일정: 동그라미 최대 3개
                let displayedSchedules = daySchedules.prefix(3)

                HStack(spacing: 3) {
                    ForEach(Array(displayedSchedules.enumerated()), id: \.offset) { _, schedule in
                        Circle()
                            .fill(schedule.color)
                            .frame(width: 6, height: 6)
                    }
                }
                .padding(.top, 12)
            } else {
                Spacer()
                    .frame(height: 18)
            }
        }
    }
}

#Preview {
    MainCalendar()
}
