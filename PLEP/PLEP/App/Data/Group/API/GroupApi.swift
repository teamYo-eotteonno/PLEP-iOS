//
//  GroupsApi.swift
//  PLEP
//
//  Created by 이다경 on 7/15/25.
//

import Foundation
import Alamofire
import RxSwift

class GroupApi: GroupProtocol {
    
    func addGroup(body: GroupRequest) -> Single<GroupModel> {
        return Single.create { single in
            let request = API.session.request(
                PLEPURL.Groups.addGroups,
                method: .post,
                parameters: body,
                encoder: JSONParameterEncoder.default
            )
                .validate()
                .responseDecodable(of: GroupModel.self) { response in
                    switch response.result {
                    case .success(let group):
                        single(.success(group))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            
            return Disposables.create { request.cancel()
            }
        }
        .observe(on: MainScheduler.instance)
    }
    
    func getGroups() -> Single<GroupModel> {
        return Single.create { single in
            let request = API.session.request(
                PLEPURL.Groups.getGroups,
                method: .get
            )
                .validate()
                .responseDecodable(of: GroupModel.self) { response in
                    switch response.result {
                    case .success(let group):
                        single(.success(group))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            
            return Disposables.create { request.cancel()
            }
        }
        .observe(on: MainScheduler.instance)
    }
    
    func editGroup(body: GroupRequest, id: Int) -> Single<EmptyResponse> {
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
    
    func deleteGroup(id: Int) -> Single<EmptyResponse> {
        return Single.create { single in
            let request = API.session.request(
                PLEPURL.Groups.deleteGroups(groupId: id),
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
