//
//  ScheduleProtocol.swift
//  PLEP
//
//  Created by 이다경 on 7/16/25.
//

import Foundation
import RxSwift
import Alamofire

protocol ScheduleProtocol {
    func addSchedule(body: ScheduleRequest, id: Int) -> Single<ScheduleModel>
    func getSchedules(startAt: String, endAt: String, groupIds: [Int]?, title: String?) -> Single<[ScheduleModel]>
    func editSchedule(body: ScheduleRequest, id: Int) -> Single<EmptyResponse>
    func deleteSchedule(id: Int) -> Single<EmptyResponse>
}
