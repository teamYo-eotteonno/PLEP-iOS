//
//  Main.swift
//  PLEP
//
//  Created by 이다경 on 6/20/25.
//

import SwiftUI

struct MainCalendarGrid: View {
    let calendar: Calendar
    let displayedMonth: Date
    let monthDays: [Date]
    let schedules: [Schedule]
    let selectedDate: Date?
    let tappedDate: Date?
    let onSelect: (_ date: Date) -> Void

    var body: some View {
        VStack(spacing: 0) {
            ForEach(monthDays.chunked(into: 7), id: \.self) { week in
                HStack(spacing: 0) {
                    ForEach(week, id: \.self) { date in
                        MainCalendarDayCell(
                            date: date,
                            calendar: calendar,
                            displayedMonth: displayedMonth,
                            schedules: schedules,
                            selectedDate: selectedDate,
                            tappedDate: tappedDate,
                            onSelect: onSelect
                        )
                    }
                }
            }
        }
    }
}
