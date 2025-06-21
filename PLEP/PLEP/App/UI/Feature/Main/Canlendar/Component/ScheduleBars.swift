//
//  ScheduleBars.swift
//  PLEP
//
//  Created by 이다경 on 6/20/25.
//

import SwiftUI

struct ScheduleBars: View {
    let weeklyDates: [[Date]]
    let schedules: [Schedule]
    let calendar: Calendar

    var body: some View {
        VStack(spacing: 5) {
            ForEach(weeklyDates.indices, id: \.self) { index in
                let week = weeklyDates[index]
                let weekStart = week.first!
                let weekEnd = week.last!

                let weekSchedules = schedules.filter { schedule in
                    let endDate = schedule.endDate ?? schedule.startDate
                    return (weekStart <= schedule.startDate && schedule.startDate <= weekEnd) ||
                           (weekStart <= endDate && endDate <= weekEnd) ||
                           (schedule.startDate <= weekStart && endDate >= weekEnd)
                }

                HStack(spacing: 0) {
                    ForEach(weekSchedules) { schedule in
                        let start = max(schedule.startDate, weekStart)
                        let end = min(schedule.endDate ?? schedule.startDate, weekEnd)

                        let leftOffset = max(0, calendar.dateComponents([.day], from: weekStart, to: start).day ?? 0)
                        let duration = max(1, calendar.dateComponents([.day], from: start, to: end).day! + 1)

                        Spacer()
                            .frame(width: CGFloat(leftOffset) * UIScreen.main.bounds.width / 7)

                        Text(schedule.name)
                            .font(.caption)
                            .padding(.horizontal, 4)
                            .frame(width: CGFloat(duration) * UIScreen.main.bounds.width / 7, height: 20, alignment: .leading)
                            .background(schedule.color)
                            .foregroundColor(.white)
                            .cornerRadius(5)

                        Spacer(minLength: 0)
                    }
                }
            }
        }
    }
}
