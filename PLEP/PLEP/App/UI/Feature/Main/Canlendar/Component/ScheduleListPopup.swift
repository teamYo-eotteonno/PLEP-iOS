//
//  ScheduleListPopup.swift
//  PLEP
//
//  Created by 이다경 on 6/18/25.
//

import SwiftUI

struct ScheduleListPopup: View {
    let day: Int
    let date: String
    let schedules: [Schedule]
    let onCreate: () -> Void
    
    @State private var showPopup = false
    @State private var popupPosition: CGPoint = .zero
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(spacing: 12) {
                HStack {
                    Text(String(day)+". ") + Text(date+"요일")
                    Spacer()
                    Button(action: onCreate) {
                        Image(Asset.Add.Rectangle.empty)
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
                .textStyle.body.bold
                .foregroundColor(.txt.primary)
                
                PLEPDivider(type: .g100)
                
                if schedules.isEmpty {
                    Text("일정이 없습니다.")
                        .textStyle.body.default
                        .foregroundColor(.txt.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 20)
                } else {
                    ForEach(schedules, id: \.id) { schedule in
                        ScheduleCell(
                            time: formattedTime(from: schedule.startDate),
                            color: schedule.color,
                            title: schedule.name,
                            alarm: 0,
                            onTap: {
                                print("짧게 누름: \(schedule.name)")
                            },
                            onLongPressWithLocation: { location in
                                popupPosition = location
                                showPopup = true
                            }
                        )
                    }
                }
                
                Spacer()
            }
            
            if showPopup {
                ScheduleCellMore(
                    onEdit: {
                        print("수정")
                        showPopup = false
                    },
                    onDelete: {
                        print("삭제")
                        showPopup = false
                    }
                )
                .position(x: popupPosition.x - 15, y: popupPosition.y - 170)
            }
        }
        .padding(.top, 15)
        .padding(.bottom, 36)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .frame(height: 477)
        .background(Color.g[0])
        .cornerRadius(15)
    }
    
    private func formattedTime(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}
