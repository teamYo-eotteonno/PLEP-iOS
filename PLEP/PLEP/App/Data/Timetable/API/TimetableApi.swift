//
//  TimetableApi.swift
//  PLEP
//
//  Created by 이다경 on 7/16/25.
//

import Foundation
import Alamofire
import RxSwift

class TimetableApi: TimetableProtocol {
    
    func addTimetable(body: TimetableRequest, id: Int) -> Single<TimetableModel> {
        return Single.create { single in
            let request = API.session.request(
                PLEPURL.Schedules.addSchedules(groupId: id),
                method: .post,
                parameters: body,
                encoder: JSONParameterEncoder.default
            )
                .validate()
                .responseDecodable(of: TimetableModel.self) { response in
                    switch response.result {
                    case .success(let timetable):
                        single(.success(timetable))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            
            return Disposables.create { request.cancel()
            }
        }
        .observe(on: MainScheduler.instance)
    }
    
    func getTimetables(scheduleId: Int, startAt: String? = nil, endAt: String? = nil, dateAt: String? = nil, title: String? = nil, groupIds: [Int]? = nil, sort: String? = nil) -> Single<TimetableModel> {
        return Single.create { single in
            var parameters: [String: Any] = [
                "scheduleId": scheduleId
            ]
            if let startAt = startAt {
                parameters["startAt"] = startAt
            }
            if let endAt = endAt {
                parameters["endAt"] = endAt
            }
            if let dateAt = dateAt {
                parameters["dateAt"] = dateAt
            }
            if let title = title {
                parameters["title"] = title
            }
            if let sort = sort {
                parameters["sort"] = sort
            }

            var filtersDict: [String: Any] = [:]
            if let groupIds = groupIds {
                filtersDict["groupIds"] = groupIds
            }
            if !filtersDict.isEmpty,
               let filterData = try? JSONSerialization.data(withJSONObject: filtersDict),
               let filterString = String(data: filterData, encoding: .utf8) {
                parameters["filters"] = filterString
            }

            let request = API.session.request(
                PLEPURL.Timetables.getTimetables(scheduleId: scheduleId),
                method: .get,
                parameters: parameters,
                encoding: URLEncoding.default
            )
            .validate()
            .responseDecodable(of: TimetableModel.self) { response in
                switch response.result {
                case .success(let timetable):
                    single(.success(timetable))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create { request.cancel() }
        }
        .observe(on: MainScheduler.instance)
    }

    func checkTimetable(id: Int) -> Single<EmptyResponse> {
        return Single.create { single in
            let request = API.session.request(
                PLEPURL.Timetables.checkTimetables(timetableId: id),
                method: .put
            )
                .validate()
                .response { response in
                    switch response.result {
                    case .success:
                        single(.success(EmptyResponse()))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            
            return Disposables.create { request.cancel()
            }
        }
    }
    
    func uncheckTimetable(id: Int) -> Single<EmptyResponse> {
        return Single.create { single in
            let request = API.session.request(
                PLEPURL.Timetables.uncheckTimetables(timetableId: id),
                method: .put
            )
                .validate()
                .response { response in
                    switch response.result {
                    case .success:
                        single(.success(EmptyResponse()))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            
            return Disposables.create { request.cancel()
            }
        }
    }
    
    func editTimetable(body: ScheduleRequest, id: Int) -> Single<EmptyResponse> {
        return Single.create { single in
            let request = API.session.request(
                PLEPURL.Timetables.editTimetables(timetableId: id),
                method: .put
            )
                .validate()
                .response { response in
                    switch response.result {
                    case .success:
                        single(.success(EmptyResponse()))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            
            return Disposables.create { request.cancel()
            }
        }
    }
    
    func deleteTimetable(id: Int) -> Single<EmptyResponse> {
        return Single.create { single in
            let request = API.session.request(
                PLEPURL.Timetables.deleteTimetables(timetableId: id),
                method: .delete
            )
                .validate()
                .response { response in
                    switch response.result {
                    case .success:
                        single(.success(EmptyResponse()))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
                
            return Disposables.create { request.cancel()
            }
        }
    }
}
