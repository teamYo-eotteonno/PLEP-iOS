//
//  ScheduleApi.swift
//  PLEP
//
//  Created by 이다경 on 7/16/25.
//

import Foundation
import Alamofire
import RxSwift

class ScheduleApi: ScheduleProtocol {
    
    func addSchedule(body: ScheduleRequest, id: Int) -> Single<ScheduleModel> {
        return Single.create { single in
            let request = API.session.request(
                PLEPURL.Schedules.addSchedules(groupId: id),
                method: .post,
                parameters: body,
                encoder: JSONParameterEncoder.default
            )
                .validate()
                .responseDecodable(of: ScheduleModel.self) { response in
                    switch response.result {
                    case .success(let schedule):
                        single(.success(schedule))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            
            return Disposables.create { request.cancel()
            }
        }
        .observe(on: MainScheduler.instance)
    }
    
    func getSchedules(startAt: String, endAt: String, groupIds: [Int]? = nil, title: String? = nil) -> Single<[ScheduleModel]> {
        return Single.create { single in
            var parameters: [String: Any] = [
                "startAt": startAt,
                "endAt": endAt
            ]

            var filtersDict: [String: Any] = [:]
            if let groupIds = groupIds {
                filtersDict["groupIds"] = groupIds
            }
            if let title = title {
                filtersDict["title"] = title
            }
            if !filtersDict.isEmpty,
               let filterData = try? JSONSerialization.data(withJSONObject: filtersDict),
               let filterString = String(data: filterData, encoding: .utf8) {
                parameters["filters"] = filterString
            }

            let request = API.session.request(
                PLEPURL.Schedules.getSchedules,
                method: .get,
                parameters: parameters,
                encoding: URLEncoding.default
            )
            .validate()
            .responseDecodable(of: [ScheduleModel].self) { response in
                switch response.result {
                case .success(let scheduleList):
                    single(.success(scheduleList))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create { request.cancel() }
        }
        .observe(on: MainScheduler.instance)
    }

    
    func editSchedule(body: ScheduleRequest, id: Int) -> Single<EmptyResponse> {
        return Single.create { single in
            let request = API.session.request(
                PLEPURL.Groups.editGroups(groupId: id),
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
    
    func deleteSchedule(id: Int) -> Single<EmptyResponse> {
        return Single.create { single in
            let request = API.session.request(
                PLEPURL.Groups.editGroups(groupId: id),
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
