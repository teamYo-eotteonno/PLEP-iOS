//
//  MiniCalendar.swift
//  PLEP
//
//  Created by 이다경 on 6/15/25.
//

import SwiftUI

struct MiniCalendar: View {
    @Binding var startDate: Date?
    @Binding var endDate: Date?
    var isSelectingStartDate: Bool
    var isSelectingEndDate: Bool
    var onDismiss: (() -> Void)? = nil
    
    @State private var calendar = Calendar.current
    @State private var currentDate = Date()
    @State private var previousMonth: Date = Date()
    @State private var transitionDirection: AnyTransition = .identity
    @State private var selectedCount = 0
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
                        .foregroundColor(.g[600])
                }
                
                Spacer()
                
                Text(displayedMonthFormatted)
                    .textStyle.body.default
                    .foregroundColor(.icon.primary)
                
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
                        .foregroundColor(.g[600])
                }
            }
            .padding(.horizontal, 10)
            
            VStack(spacing: 0) {
                HStack {
                    ForEach(daysOfWeek, id: \.self) { day in
                        Text(day)
                            .textStyle.title.pre
                            .foregroundColor(.icon.primary)
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
                let isSelected = (startDate == date || endDate == date)
                let isTapped = tappedDate == date
                
                Button {
                    if !isFuture {
                        if tappedDate == date {
                            if isSelectingStartDate {
                                if let end = endDate, date > end {
                                    return
                                }
                                startDate = date
                            } else if isSelectingEndDate {
                                if let start = startDate, date < start {
                                    return
                                }
                                endDate = date
                            }
                            tappedDate = nil
                            onDismiss?()
                        } else {
                            tappedDate = date
                        }
                    }
                }
                label: {
                    Text("\(calendar.component(.day, from: date))")
                        .frame(maxWidth: .infinity)
                        .frame(height: 30)
                        .background(
                            Circle()
                                .fill(
                                    isSelected ? .p[300]
                                    : isTapped ? .p[100]
                                    : Color.clear
                                )
                                .frame(width: 31)
                        )
                        .foregroundColor(
                            isSelected ? .g[0]
                            : isTapped ? .icon.primary
                            : (isCurrentMonth ? .icon.primary : .icon.quartemary)
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
