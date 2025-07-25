//
//  MainCalendarViewModel.swift
//  PLEP
//
//  Created by 이다경 on 7/16/25.
//

import RxSwift
import Combine
import SwiftUI

class MainCalendarViewModel: ObservableObject {
    private let disposeBag = DisposeBag()
    
    @Published var group: GroupModel?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var schedule: ScheduleModel?
    @Published var schedules: [Schedule] = []
    @Published var selectedDate: Date = {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
        return calendar.startOfDay(for: Date())
    }()
    
    @Published var groups: [GroupModel]?
    
    private let groupApi: GroupApi
    private let scheduleApi: ScheduleApi
    
    init(gapi: GroupApi, sapi: ScheduleApi) {
        self.groupApi = gapi
        self.scheduleApi = sapi
    }
    
    var schedulesForSelectedDate: [Schedule] {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
        let cellDate = calendar.startOfDay(for: selectedDate)

        return schedules.filter { schedule in
            guard let endDate = schedule.endDate else {
                return calendar.isDate(schedule.startDate, inSameDayAs: selectedDate)
            }
            return (schedule.startDate <= cellDate) && (cellDate <= endDate)
        }
    }
    
    func addGroup(body: GroupRequest, completion: @escaping (Result<GroupModel, Error>) -> Void) {
        isLoading = true
        groupApi.addGroup(body: body)
            .subscribe { [weak self] group in
                self?.isLoading = false
                print("그룹 추가 성공: \(group)")
                self?.getGroups()
                completion(.success(group))
            } onFailure: { [weak self] error in
                self?.isLoading = false
                self?.errorMessage = error.localizedDescription
                print("그룹 추가 실패: \(error.localizedDescription)")
                completion(.failure(error))
            }
            .disposed(by: disposeBag)
    }
    
    func getGroups() {
        isLoading = true
        groupApi.getGroups()
            .subscribe { [weak self] groups in
                self?.isLoading = false
                self?.groups = groups
                print("그룹 목록 가져오기 성공: \(groups)")
            } onFailure: { [weak self] error in
                self?.isLoading = false
                self?.errorMessage = error.localizedDescription
                print("그룹 목록 가져오기 실패: \(error.localizedDescription)")
            }
            .disposed(by: disposeBag)
    }
    
    func editGroup(body: GroupRequest, id: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        isLoading = true
        
        groupApi.editGroup(body: body, id: id)
            .subscribe { [weak self] _ in
                self?.isLoading = false
                print("그룹 수정 성공 (id: \(id))")
                self?.getGroups()
                completion(.success(()))
            } onFailure: { [weak self] error in
                self?.isLoading = false
                self?.errorMessage = error.localizedDescription
                print("그룹 수정 실패: \(error.localizedDescription)")
                completion(.failure(error))
            }
            .disposed(by: disposeBag)
    }
    
    func deleteGroup(id: Int) {
        isLoading = true
        groupApi.deleteGroup(id: id)
            .subscribe { [weak self] _ in
                self?.isLoading = false
                print("그룹 삭제 성공 (id: \(id))")
                self?.getGroups()
            } onFailure: { [weak self] error in
                self?.isLoading = false
                self?.errorMessage = error.localizedDescription
                print("그룹 삭제 실패: \(error.localizedDescription)")
            }
            .disposed(by: disposeBag)
    }
    
    func addSchedule(body: ScheduleRequest, id: Int, completion: @escaping (Result<ScheduleModel, Error>) -> Void) {
        isLoading = true
        scheduleApi.addSchedule(body: body, id: id)
            .subscribe { [weak self] schedule in
                self?.isLoading = false
                print("스케줄 추가 성공: \(schedule)")
                self?.getGroups()
                completion(.success(schedule))
            } onFailure: { [weak self] error in
                self?.isLoading = false
                self?.errorMessage = error.localizedDescription
                print("스케줄 추가 실패: \(error.localizedDescription)")
                completion(.failure(error))
            }
            .disposed(by: disposeBag)
    }
    
    func getSchedules(startAt: String, endAt: String, groupIds: [Int]? = nil, title: String? = nil) {
        isLoading = true
        scheduleApi.getSchedules(startAt: startAt, endAt: endAt, groupIds: groupIds, title: title)
            .subscribe { [weak self] scheduleList in
                guard let self = self else { return }
                self.isLoading = false
                self.schedules = scheduleList.map { $0.toSchedule() }
                print("스케줄 목록 가져오기 성공: \(self.schedules)")
            } onFailure: { [weak self] error in
                guard let self = self else { return }
                self.isLoading = false
                self.errorMessage = error.localizedDescription
                print("스케줄 목록 가져오기 실패: \(error.localizedDescription)")
            }
            .disposed(by: disposeBag)
    }
}

extension MainCalendarViewModel {
    func schedules(for date: Date) -> [Schedule] {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
        
        return schedules.filter {
            guard let endDate = $0.endDate else {
                return calendar.isDate($0.startDate, inSameDayAs: date)
            }
            
            let cellDate = calendar.startOfDay(for: date)
            let startDate = calendar.startOfDay(for: $0.startDate)
            let endDateStart = calendar.startOfDay(for: endDate)
            
            return (startDate <= cellDate) && (cellDate <= endDateStart)
        }
    }
}
