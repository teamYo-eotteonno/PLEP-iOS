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
                    (weekStart <= schedule.startDate && schedule.startDate <= weekEnd) ||
                    (weekStart <= schedule.endDate && schedule.endDate <= weekEnd) ||
                    (schedule.startDate <= weekStart && schedule.endDate >= weekEnd)
                }

                HStack(spacing: 0) {
                    ForEach(weekSchedules) { schedule in
                        let leftOffset = max(0, calendar.dateComponents([.day], from: weekStart, to: max(schedule.startDate, weekStart)).day ?? 0)
                        let duration = min(7 - leftOffset, calendar.dateComponents([.day], from: max(schedule.startDate, weekStart), to: min(schedule.endDate, weekEnd)).day! + 1)

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
