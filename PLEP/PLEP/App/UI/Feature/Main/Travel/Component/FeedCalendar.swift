//
//  FeedCalendar.swift
//  PLEP
//
//  Created by 이다경 on 6/7/25.
//

import SwiftUI

struct FeedCalendar: View {
    @State private var calendar = Calendar.current
    @State private var currentDate = Date()
    @State private var previousMonth: Date = Date()
    @State private var transitionDirection: AnyTransition = .identity
    
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
            VStack(spacing: 17) {
                Text("날짜 선택")
                    .textStyle.body.bold
                    .foregroundColor(.txt.primary)
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)
                    .foregroundColor(.g[200])
            }
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
            .padding(.horizontal, 10)
            
            VStack(spacing: -10) {
                HStack {
                    ForEach(daysOfWeek, id: \.self) { day in
                        Text(day)
                            .textStyle.title.pre
                            .foregroundColor(.txt.primary)
                            .frame(maxWidth: .infinity)
                    }
                }
                calendarGridView()
                    .textStyle.body.default
                    .transition(transitionDirection)
            }
            .padding(.all, 10)
        }
        .padding(.all, 20)
        .background(Color.g[0])
        .cornerRadius(20)
    }
    
    private func calendarGridView() -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
            ForEach(monthDays, id: \.self) { date in
                let isCurrentMonth = calendar.isDate(date, equalTo: displayedMonth, toGranularity: .month)
                let isFuture = date > Date()
                let isSelected = selectedDate == date
                let isTapped = tappedDate == date
                
                Button {
                    if !isFuture {
                        if isTapped {
                            selectedDate = date
                        } else {
                            tappedDate = date
                        }
                    }
                } label: {
                    Text("\(calendar.component(.day, from: date))")
                        .frame(maxWidth: .infinity, minHeight: 54.17)
                        .background(
                            Circle()
                                .fill(
                                    isSelected ? Color.blue.opacity(0.3)
                                    : isTapped ? .p[300]
                                    : Color.clear
                                )
                                .frame(width: 31)
                        )
                        .foregroundColor(
                            isTapped ? .g[0]
                            : (isCurrentMonth ? .txt.primary : .txt.quartemary)
                        )
                }
                .disabled(isFuture)
            }
        }
    }
    
    private var displayedMonthFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월"
        return formatter.string(from: displayedMonth)
    }
}

#Preview {
    FeedCalendar()
}
