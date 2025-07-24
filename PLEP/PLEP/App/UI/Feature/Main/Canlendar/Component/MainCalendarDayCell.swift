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
    let onSelect: (_ date: Date) -> Void

    var body: some View {
        let isCurrentMonth = calendar.isDate(date, equalTo: displayedMonth, toGranularity: .month)
        let isOtherMonth = !isCurrentMonth
        let today = calendar.startOfDay(for: Date())
        let cellDate = calendar.startOfDay(for: date)
        let isToday = (cellDate == today)

        let daySchedules = schedules.filter {
            let scheduleStartDay = calendar.startOfDay(for: $0.startDate)
            let scheduleEndDay = calendar.startOfDay(for: $0.endDate ?? $0.startDate)
            return (scheduleStartDay ... scheduleEndDay).contains(cellDate)
        }

        return Button {
            onSelect(date)
        } label: {
            VStack(spacing: 0) {
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

                if daySchedules.count == 1, let schedule = daySchedules.first {
                    let scheduleStartDay = calendar.startOfDay(for: schedule.startDate)
                    let scheduleEndDay = calendar.startOfDay(for: schedule.endDate ?? schedule.startDate)

                    let isStart = calendar.isDate(cellDate, inSameDayAs: scheduleStartDay)
                    let isEnd = calendar.isDate(cellDate, inSameDayAs: scheduleEndDay)

                    let isSingleDay = isStart && isEnd

                    if isSingleDay {
                        HStack(spacing: 3) {
                            RoundedRectangle(cornerRadius: 2)
                                .fill(schedule.color)
                                .frame(width: 2, height: 20)
                            Text(schedule.name)
                                .textStyle.title.pre
                                .foregroundColor(.txt.secondary)
                                .lineLimit(1)
                            Spacer()
                        }
                        .padding(.top, 8)
                        .padding(.leading, 5)
                    } else {
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

                            if isStart {
                                Text(schedule.name)
                                    .textStyle.title.pre
                                    .foregroundColor(.txt.secondary)
                                    .lineLimit(1)
                                    .padding(.leading, 6)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(.top, 10)
                    }
                } else if daySchedules.count > 1 {
                    HStack(spacing: 5.5) {
                        ForEach(Array(daySchedules.prefix(3).enumerated()), id: \.offset) { _, schedule in
                            Circle()
                                .fill(schedule.color)
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(.top, 16)
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
