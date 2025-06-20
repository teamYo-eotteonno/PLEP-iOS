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

    private static func makeDate(_ dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        return formatter.date(from: dateString) ?? Date()
    }

    @State private var schedules: [Schedule] = [
        Schedule(name: "긴 일정", startDate: makeDate("2025-06-10"), endDate: makeDate("2025-06-30"), color: .blue)
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

        // 이전 달
        if let previousMonth = calendar.date(byAdding: .month, value: -1, to: displayedMonth) {
            let leading = firstWeekday - 1
            for i in (0..<leading).reversed() {
                if let day = calendar.date(byAdding: .day, value: -i - 1, to: firstOfMonth) {
                    days.append(day)
                }
            }
        }

        // 현재 달
        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: firstOfMonth) {
                days.append(date)
            }
        }

        // 다음 달
        while days.count < 42 {
            if let last = days.last, let next = calendar.date(byAdding: .day, value: 1, to: last) {
                days.append(next)
            }
        }

        return days
    }

    var body: some View {
        VStack(spacing: 12) {
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

//                Spacer()

                Text(displayedMonthFormatted)
                    .textStyle.body.default
                    .foregroundColor(.txt.primary)

//                Spacer()

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
            
//            .padding(.horizontal, 10)

            VStack(spacing: 5) {
                HStack {
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
                        if tappedDate == date {
                            selectedDate = date
                        } else {
                            tappedDate = date
                        }
                    }
                )
                .textStyle.body.default
                .transition(transitionDirection)
            }
//            .padding(.all, 10)
        }
//        .padding(.all, 20)
//        .background(Color.g[0])
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

#Preview {
    MainCalendar()
}
