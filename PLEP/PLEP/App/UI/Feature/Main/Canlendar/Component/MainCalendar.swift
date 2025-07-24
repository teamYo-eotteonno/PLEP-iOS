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

    @ObservedObject var viewModel: MainCalendarViewModel
    
    let onSelect: (Date) -> Void

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

        let leading = firstWeekday - 1
        for i in (0..<leading).reversed() {
            if let day = calendar.date(byAdding: .day, value: -i - 1, to: firstOfMonth) {
                days.append(day)
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
                    fetchSchedulesForCurrentMonth()
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
                        fetchSchedulesForCurrentMonth()
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
                    schedules: viewModel.schedules,
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
        .onAppear {
            fetchSchedulesForCurrentMonth()
        }
    }

    private func fetchSchedulesForCurrentMonth() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        
        let start = formatter.string(from: firstDateOfMonth())
        let end = formatter.string(from: lastDateOfMonth())

        viewModel.getSchedules(startAt: start, endAt: end)
    }

    private func firstDateOfMonth() -> Date {
        calendar.date(from: calendar.dateComponents([.year, .month], from: displayedMonth))!
    }

    private func lastDateOfMonth() -> Date {
        let comps = DateComponents(month: 1, day: -1)
        return calendar.date(byAdding: comps, to: firstDateOfMonth())!
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

extension ScheduleModel {
    func toSchedule() -> Schedule {
        Schedule(
            name: self.title,
            startDate: Self.parseDate(self.startAt),
            endDate: Self.parseDate(self.endAt),
            color: convertStringToColor(self.group?.color ?? "") ?? .blue
        )
    }

    private static func parseDate(_ dateString: String) -> Date {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        formatter.timeZone = TimeZone(secondsFromGMT: 9 * 60 * 60)

        guard let date = formatter.date(from: dateString) else { return Date() }

        return date
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: [UIRectCorner]) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners.reduce([]) { $0.union($1) }))
    }
}
