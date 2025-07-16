//
//  TimetableProtocol.swift
//  PLEP
//
//  Created by 이다경 on 7/16/25.
//

import Foundation
import RxSwift
import Alamofire

protocol TimetableProtocol {
    func addTimetable(body: TimetableRequest, id: Int) -> Single<TimetableModel>
    func getTimetables(scheduleId: Int, startAt: String?, endAt: String?, dateAt: String?, title: String?, groupIds: [Int]?, sort: String?) -> Single<TimetableModel>
    func checkTimetable(id: Int) -> Single<EmptyResponse>
    func uncheckTimetable(id: Int) -> Single<EmptyResponse>
    func editTimetable(body: ScheduleRequest, id: Int) -> Single<EmptyResponse>
    func deleteTimetable(id: Int) -> Single<EmptyResponse>
}
