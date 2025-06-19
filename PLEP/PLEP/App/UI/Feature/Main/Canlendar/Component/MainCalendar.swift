//
//  MainCalendar.swift
//  PLEP
//
//  Created by 이다경 on 6/19/25.
//

import SwiftUI

struct Schedule: Identifiable {
    let id = UUID()
    let name: String
    let startDate: Date
    let endDate: Date
    var color: Color = .blue
}


struct ScheduleBarsView: View {
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

import SwiftUI

struct CalendarDayCell: View {
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

struct CalendarGridView: View {
    let calendar: Calendar
    let displayedMonth: Date
    let monthDays: [Date]
    let schedules: [Schedule]
    let selectedDate: Date?
    let tappedDate: Date?
    let onSelect: (Date) -> Void

    var body: some View {
        VStack(spacing: 0) {
            ForEach(monthDays.chunked(into: 7), id: \.self) { week in
                HStack(spacing: 0) {
                    ForEach(week, id: \.self) { date in
                        CalendarDayCell(
                            date: date,
                            calendar: calendar,
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

extension View {
    func cornerRadius(_ radius: CGFloat, corners: [UIRectCorner]) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners.reduce([]) { $0.union($1) }))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
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
            HStack {
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

                Spacer()

                Text(displayedMonthFormatted)
                    .textStyle.body.default
                    .foregroundColor(.txt.primary)

                Spacer()

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
            }
//            .padding(.horizontal, 10)

            VStack(spacing: -10) {
                HStack {
                    ForEach(daysOfWeek, id: \.self) { day in
                        Text(day)
                            .textStyle.title.pre
                            .foregroundColor(.txt.primary)
                            .frame(maxWidth: .infinity)
                    }
                }

                CalendarGridView(
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

#Preview {
    MainCalendar()
}
