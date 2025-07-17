//
//  ScheduleAddView.swift
//  PLEP
//
//  Created by 이다경 on 6/16/25.
//

import SwiftUI
import FlowKit

struct ScheduleAddView: View {
    @Flow var flow
    @State private var title: String = ""
    @State private var alarm: Bool = false
    @State private var selection = ""
    
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    @State private var startTime: String? = nil
    @State private var endTime: String? = nil
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var onDismiss: (() -> Void)? = nil
    @Environment(\.dismiss) private var dismiss
    
    var groups: [GroupModel]
    @ObservedObject var viewModel: MainCalendarViewModel
    
    var isFormValid: Bool {
        return !title.trimmingCharacters(in: .whitespaces).isEmpty
        && !selection.isEmpty
        && startDate != nil
        && endDate != nil
        && startTime != nil
        && endTime != nil
    }
    
    var body: some View {
        ZStack {
            Color.g[50].ignoresSafeArea()
            VStack(spacing: 0) {
                PLEPTopbar(type: .text("일정 추가"), action: { onDismiss?() })
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 23) {
                        PLEPTextField(
                            text: $title,
                            placeholder: "제목을 입력해주세요",
                            errorMessage: "제목을 입력해주세요"
                        )
                        
                        ScheduleDateAndTime(
                            startDate: $startDate,
                            endDate: $endDate,
                            startTime: $startTime,
                            endTime: $endTime
                        )
                        
                        let uniqueOptions = Dictionary(
                            groups.compactMap { group in
                                if let color = convertStringToColor(group.color) {
                                    return (color, group.name)
                                } else {
                                    return nil
                                }
                            },
                            uniquingKeysWith: { first, _ in first }
                        )
                        
                        PLEPDropdown(
                            title: "그룹 선택",
                            options: uniqueOptions,
                            selection: $selection
                        )
                    }
                    .padding(.top, 30)
                    
                    PLEPButton(
                        title: "저장",
                        type: .filled,
                        size: .small,
                        enabled: isFormValid,
                        action: { addSchedule() }
                    )
                    .padding(.top, 50)
                }
                .padding(.horizontal, 25)
            }
        }
        .navigationBarHidden(true)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("오류"), message: Text(alertMessage), dismissButton: .default(Text("확인")))
        }
    }
    
    private func addSchedule() {
        guard let startDate = startDate,
              let endDate = endDate,
              let startTime = startTime,
              let endTime = endTime else { return }
        
        guard let selectedGroup = groups.first(where: { $0.name == selection }) else {
            print("선택된 그룹을 찾을 수 없습니다.")
            alertMessage = "선택된 그룹을 찾을 수 없습니다."
            showAlert = true
            return
        }
        
        guard let startAt = iso8601String(date: startDate, time: startTime),
              let endAt = iso8601String(date: endDate, time: endTime) else {
            print("날짜 변환 실패")
            alertMessage = "날짜 변환 실패"
            showAlert = true
            return
        }
        
        let request = ScheduleRequest(
            title: title,
            startAt: startAt,
            endAt: endAt
        )
        
        viewModel.addSchedule(body: request, id: selectedGroup.id) { result in
            switch result {
            case .success(let schedule):
                print("스케줄 추가 완료: \(schedule)")
                onDismiss?()
            case .failure(let error):
                print("스케줄 추가 실패: \(error.localizedDescription)")
                alertMessage = "스케줄 추가 실패: \(error.localizedDescription)"
                showAlert = true
            }
        }
    }
}

private func iso8601String(date: Date, time: String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    let datePart = dateFormatter.string(from: date)
    let dateTimeString = datePart + " " + time
    
    let dateTimeFormatter = DateFormatter()
    dateTimeFormatter.locale = Locale(identifier: "ko_KR")
    dateTimeFormatter.timeZone = TimeZone.current
    dateTimeFormatter.dateFormat = "yyyy-MM-dd a h:mm"
    
    guard let combinedDate = dateTimeFormatter.date(from: dateTimeString) else {
        print("날짜 변환 실패: \(dateTimeString)")
        return nil
    }
    
    let isoFormatter = ISO8601DateFormatter()
    isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    isoFormatter.timeZone = TimeZone.current
    
    return isoFormatter.string(from: combinedDate)
}
