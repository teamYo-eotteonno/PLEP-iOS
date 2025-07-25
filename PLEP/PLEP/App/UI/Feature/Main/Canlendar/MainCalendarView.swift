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
    @State private var showAddSheet = false
    @State private var showScheduleListPopup = false
    @State private var selectedDate: Date?
    
    @StateObject var viewModel: MainCalendarViewModel
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State private var editingGroup: GroupModel?
    @State private var isEditing = false
    
    @State private var selectedSchedule: ScheduleModel?
    
    @State private var showAddScheduleView = false
    
    var groupsDictionary: [Int: (Color, String)] {
        guard let groups = viewModel.groups else { return [:] }
        var dict: [Int: (Color, String)] = [:]
        
        for group in groups {
            if let color = convertStringToColor(group.color) {
                dict[group.id] = (color, group.name)
            }
        }
        return dict
    }
    
    var selectedDayAndWeekday: (day: Int, weekdayString: String)? {
        guard let selectedDate = selectedDate else { return nil }

        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!

        let day = calendar.component(.day, from: selectedDate)
        let weekday = calendar.component(.weekday, from: selectedDate)

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "UTC")!
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
                        groups: viewModel.groups ?? [],
                        selectedIndex: $selectedIndex,
                        onAdd: { showAddSheet.toggle() },
                        onSetting: { index in
                            print("그룹 \(index) 길게 누름")
                            if let groups = viewModel.groups, groups.indices.contains(index) {
                                editingGroup = groups[index]
                                selectedIndex = index
                                isEditing = false
                            }
                        }
                    )
                }
                .padding(.horizontal, 25)
                
                VStack(spacing: 16) {
                    MainCalendar(viewModel: viewModel) { selected in
                        print("외부에서 날짜 선택됨: \(selected)")
                        selectedDate = selected
                        viewModel.selectedDate = selected
                        showScheduleListPopup.toggle()
                    }
                    PLEPButton(
                        title: "일정 생성",
                        type: .neutral,
                        size: .small,
                        enabled: true,
                        action: {
                            showAddScheduleView = true
                            viewModel.getGroups()
                        }
                    )
                    .padding(.horizontal, 25)
                }
                .padding(.vertical, 30)
                .background(Color.g[0])
                
                Spacer()
            }
            .sheet(isPresented: $showAddSheet, onDismiss: {
                print("사용자가 직접 시트 닫음 -> 취소 처리")
            }) {
                VStack(spacing: 0) {
                    Capsule()
                        .foregroundColor(.g[500])
                        .frame(width: 64, height: 1)
                        .padding(.vertical, 20)

                    GroupSettingSheet(
                        type: .can,
                        onComplete: { name, color in
                            let colorString = convertColorToString(color)
                            let body = GroupRequest(name: name, color: colorString)
                            
                            viewModel.addGroup(body: body) { result in
                                switch result {
                                case .success:
                                    showAddSheet = false
                                case .failure(let error):
                                    alertMessage = error.localizedDescription
                                    showAlert = true
                                }
                            }
                        }
                    )
                }
                .background(Color.g[0])
                .cornerRadius(20)
                .presentationDetents([.fraction(0.6)])
                .presentationDragIndicator(.hidden)
            }
            .sheet(item: $editingGroup) { group in
                VStack(spacing: 0) {
                    Capsule()
                        .foregroundColor(.g[500])
                        .frame(width: 64, height: 1)
                        .padding(.vertical, 20)

                    GroupSettingSheet(
                        type: isEditing ? .can : .more,
                        groupNameInitial: group.name,
                        selectedColorInitial: convertStringToColor(group.color) ?? .file.red,
                        onComplete: { name, color in
                            let colorString = convertColorToString(color)
                            let body = GroupRequest(name: name, color: colorString)
                            
                            print(body)
                            
                            viewModel.editGroup(body: body, id: group.id) { result in
                                switch result {
                                case .success:
                                    editingGroup = nil
                                case .failure(let error):
                                    alertMessage = error.localizedDescription
                                    showAlert = true
                                }
                            }
                        }, onEdit: {
                            isEditing = true
                        }
                    )
                }
                .background(Color.g[0])
                .cornerRadius(20)
                .presentationDetents(isEditing ? [.fraction(0.6)] : [.fraction(0.3)])
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
                    schedules: viewModel.schedules(for: selectedDate ?? Date()),
                    onCreate: {
                        print("일정 생성")
                        viewModel.getGroups()
                        showAddScheduleView = true
                    }
                )
                .padding(.horizontal, 49)
            }
        }
        .padding(.top, 78)
        .ignoresSafeArea()
        .onAppear {
            viewModel.getGroups()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("오류"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
        }
        .fullScreenCover(isPresented: $showAddScheduleView) {
            ScheduleAddView(
                onDismiss: { showAddScheduleView = false },
                groups: viewModel.groups ?? [],
                viewModel: viewModel
            )
        }
    }
}

func convertStringToColor(_ string: String) -> Color? {
    switch string.lowercased() {
    case "red": return .file.red
    case "orange": return .file.orange
    case "yellow": return .file.yellow
    case "lime": return .file.lame
    case "green": return .file.green
    case "sky": return .file.sky
    case "blue": return .file.blue
    case "purple": return .file.purple
    case "magenta": return .file.magenta
    case "pink": return .file.pink
    default: return nil
    }
}

func convertColorToString(_ color: Color) -> String {
    switch color {
    case .file.red: return "red"
    case .file.orange: return "orange"
    case .file.yellow: return "yellow"
    case .file.lame: return "lime"
    case .file.green: return "green"
    case .file.sky: return "sky"
    case .file.blue: return "blue"
    case .file.purple: return "purple"
    case .file.magenta: return "magenta"
    case .file.pink: return "pink"
    default: return "unknown"
    }
}
