//
//  MainCalendar.swift
//  PLEP
//
//  Created by 이다경 on 6/19/25.
//

import SwiftUI

struct MainCalendar: View {
    @State private var calendar = Calendar.current
    @State private var currentDate = Date()
    @State private var previousMonth: Date = Date()
    @State private var transitionDirection: AnyTransition = .identity
    
    let onSelect: (Date) -> Void

    private static func makeDate(_ dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        return formatter.date(from: dateString) ?? Date()
    }

    @State private var schedules: [Schedule] = [
        // 하루짜리 일정 1개 (텍스트+사각형)
        Schedule(name: "A", startDate: makeDate("2025-06-03"), color: .red),

        // 하루짜리 일정 여러 개 (동그라미로 표시)
        Schedule(name: "B", startDate: makeDate("2025-06-04"), color: .green),
        Schedule(name: "C", startDate: makeDate("2025-06-04"), color: .blue),
        Schedule(name: "D", startDate: makeDate("2025-06-04"), color: .purple),
        
        // 장기 일정 1개 (바+텍스트)
        Schedule(name: "긴 일정 A", startDate: makeDate("2025-06-05"), endDate: makeDate("2025-06-10"), color: .orange),
        
        // 장기 + 하루 일정 같이 있음 (동그라미 2개 표시)
        Schedule(name: "긴 일정 B", startDate: makeDate("2025-06-11"), endDate: makeDate("2025-06-13"), color: .cyan),
        Schedule(name: "하루 일정 E", startDate: makeDate("2025-06-12"), color: .mint),
        
        // 하루 일정 4개 (동그라미 3개까지만 표시됨)
        Schedule(name: "하루 일정 F", startDate: makeDate("2025-06-14"), color: .pink),
        Schedule(name: "하루 일정 G", startDate: makeDate("2025-06-14"), color: .brown),
        Schedule(name: "하루 일정 H", startDate: makeDate("2025-06-14"), color: .indigo),
        Schedule(name: "하루 일정 I", startDate: makeDate("2025-06-14"), color: .gray),
        
        // 장기 일정 2개 겹침 (동그라미 2개 표시)
        Schedule(name: "긴 일정 C", startDate: makeDate("2025-06-16"), endDate: makeDate("2025-06-18"), color: .yellow),
        Schedule(name: "긴 일정 D", startDate: makeDate("2025-06-17"), endDate: makeDate("2025-06-19"), color: .teal),
    ]

    @State private var selectedDate: Date?
    @State private var tappedDate: Date?

    private let daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"]

    private var displayedMonth: Date {
        calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate))!
    }

    private var monthDays: [Date] {
        guard let firstOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: displayedMonth)),
              let range = calendar.range(of: .day, in: .month, for: displayedMonth) else {
            return []
        }

        let firstWeekday = calendar.component(.weekday, from: firstOfMonth)
        var days: [Date] = []

        if let previousMonth = calendar.date(byAdding: .month, value: -1, to: displayedMonth) {
            let leading = firstWeekday - 1
            for i in (0..<leading).reversed() {
                if let day = calendar.date(byAdding: .day, value: -i - 1, to: firstOfMonth) {
                    days.append(day)
                }
            }
        }

        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstOfMonth) {
                days.append(date)
            }
        }
        
        while days.count < 42 {
            if let last = days.last, let next = calendar.date(byAdding: .day, value: 1, to: last) {
                days.append(next)
            }
        }

        return days
    }

    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 32) {
                Spacer()
                Button {
                    previousMonth = currentDate
                    currentDate = calendar.date(byAdding: .month, value: -1, to: currentDate)!
                    transitionDirection = .asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing))
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 10, height: 20)
                        .foregroundColor(.icon.secondary)
                }
                
                Text(displayedMonthFormatted)
                    .textStyle.body.default
                    .foregroundColor(.txt.primary)
                
                Button {
                    withAnimation(.easeInOut) {
                        previousMonth = currentDate
                        currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate)!
                        transitionDirection = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .resizable()
                        .frame(width: 10, height: 20)
                        .foregroundColor(.icon.secondary)
                }
                Spacer()
            }

            VStack(spacing: 5) {
                HStack(spacing: 0) {
                    ForEach(daysOfWeek, id: \.self) { day in
                        Text(day)
                            .textStyle.title.pre
                            .foregroundColor(.txt.primary)
                            .frame(maxWidth: .infinity)
                    }
                }

                MainCalendarGrid(
                    calendar: calendar,
                    displayedMonth: displayedMonth,
                    monthDays: monthDays,
                    schedules: schedules,
                    selectedDate: selectedDate,
                    tappedDate: tappedDate,
                    onSelect: { date in
                        tappedDate = date
                        selectedDate = date
                        onSelect(date)
                    }
                )
                .transition(transitionDirection)
            }
        }
    }

    private var displayedMonthFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월"
        return formatter.string(from: displayedMonth)
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: [UIRectCorner]) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners.reduce([]) { $0.union($1) }))
    }
}
