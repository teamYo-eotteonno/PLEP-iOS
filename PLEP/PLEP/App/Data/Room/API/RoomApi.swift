//
//  RoomApi.swift
//  PLEP
//
//  Created by 이다경 on 7/16/25.
//

import Foundation
import Alamofire
import RxSwift

class RoomApi: RoomProtocol {
    
    func addRoom(body: RoomRequest) -> Single<RoomModel> {
        return Single.create { single in
            let request = API.session.request(
                PLEPURL.Rooms.addRooms,
                method: .post,
                parameters: body,
                encoder: JSONParameterEncoder.default
            )
                .validate()
                .responseDecodable(of: RoomModel.self) { response in
                    switch response.result {
                    case .success(let room):
                        single(.success(room))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            
            return Disposables.create { request.cancel()
            }
        }
        .observe(on: MainScheduler.instance)
    }
    
    func getRooms() -> Single<RoomModel> {
        return Single.create { single in
            let request = API.session.request(
                PLEPURL.Rooms.getRooms,
                method: .get
            )
                .validate()
                .responseDecodable(of: RoomModel.self) { response in
                    switch response.result {
                    case .success(let room):
                        single(.success(room))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            
            return Disposables.create { request.cancel()
            }
        }
        .observe(on: MainScheduler.instance)
    }
    
    func joinRoom(id: Int) -> Single<EmptyResponse> {
        return Single.create { single in
            let request = API.session.request(
                PLEPURL.Rooms.joinRooms(roomId: id),
                method: .post
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
    
    func kickRoom(id: Int) -> Single<EmptyResponse> {
        return Single.create { single in
            let request = API.session.request(
                PLEPURL.Rooms.kickUser(userId: id),
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

    func leaveRoom() -> Single<EmptyResponse> {
        return Single.create { single in
            let request = API.session.request(
                PLEPURL.Rooms.leaveRooms,
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
