//
//  MainCalendarView.swift
//  PLEP
//
//  Created by 이다경 on 6/21/25.
//

import SwiftUI
import FlowKit

struct MainCalendarView: View {
    @Flow var flow
    @State private var search = ""
    @State private var selectedIndex: Int?
    @State private var showSettingSheet = false
    @State private var showAddSheet = false
    @State private var showScheduleListPopup = false
    @State private var selectedDate: Date?
    
    var selectedDayAndWeekday: (day: Int, weekdayString: String)? {
        guard let selectedDate = selectedDate else { return nil }

        let calendar = Calendar.current
        let day = calendar.component(.day, from: selectedDate)
        let weekday = calendar.component(.weekday, from: selectedDate)

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        let weekdayString = formatter.shortWeekdaySymbols[weekday - 1]

        return (day, weekdayString)
    }
    
    var body: some View {
        ZStack {
            Color.g[50].ignoresSafeArea()
            VStack(spacing: 25) {
                VStack(spacing: 20) {
                    PLEPTextField(
                        text: $search,
                        placeholder: "일정을 입력해주세요",
                        isSecure: false,
                        validate: { !$0.isEmpty },
                        errorMessage: "일정을 입력해주세요",
                        icon_t: true
                    )
                    GroupList(
                        groups: [
                            .red: "개인",
                            .blue: "학교",
                            .green: "팀플",
                            .orange: "알바"
                        ],
                        selectedIndex: $selectedIndex,
                        onAdd: { showAddSheet.toggle() },
                        onSetting: { index in
                            print("그룹 \(index) 길게 누름")
                            selectedIndex.self
                            print(selectedIndex)
                            print(index)
                            if selectedIndex != nil {
                                showSettingSheet.toggle()
                            }
                        }
                    )
                }
                .padding(.horizontal, 25)
                VStack(spacing: 16) {
                    MainCalendar{ selected in
                        print("외부에서 날짜 선택됨: \(selectedDate)")
                        selectedDate = selected
                        showScheduleListPopup.toggle()
                    }
                    PLEPButton(
                        title: "일정 생성",
                        type: .neutral,
                        size: .small,
                        enabled: true,
                        action: { flow.push(ScheduleAddView()) }
                    )
                    .padding(.horizontal, 25)
                }
                .padding(.vertical, 30)
                .background(Color.g[0])
                Spacer()
            }
            .sheet(isPresented: $showAddSheet) {
                VStack(spacing: 0) {
                        Capsule()
                            .foregroundColor(.g[500])
                            .frame(width: 64, height: 1)
                            .padding(.vertical, 20)

                    GroupSettingSheet(type: .can)
                    }
                    .background(Color.g[0])
                    .cornerRadius(20)
                    .presentationDetents([.fraction(0.6)])
                    .presentationDragIndicator(.hidden)
            }
            .sheet(isPresented: $showSettingSheet) {
                VStack(spacing: 0) {
                    Capsule()
                        .foregroundColor(.g[500])
                        .frame(width: 64, height: 1)
                        .padding(.vertical, 20)

                    if index != nil {
                        GroupSettingSheet(type: .more)
                    } else {
                        EmptyView()
                    }
                }
                .background(Color.g[0])
                .cornerRadius(20)
                .presentationDetents([.fraction(0.3)])
                .presentationDragIndicator(.hidden)
            }
            if showScheduleListPopup, let info = selectedDayAndWeekday {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showScheduleListPopup = false
                    }

                ScheduleListPopup(
                    day: info.day,
                    date: info.weekdayString,
                    onCreate: {
                        print("일정 생성")
                        flow.push(ScheduleAddView())
                    }
                )
                .padding(.horizontal, 49)
            }
        }
        .padding(.top, 78)
        .ignoresSafeArea()
    }
}

#Preview {
    FlowPresenter(rootView: HomeView())
        .ignoresSafeArea()
}

