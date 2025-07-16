//
//  RoomProtocol.swift
//  PLEP
//
//  Created by 이다경 on 7/16/25.
//

import Foundation
import RxSwift
import Alamofire

protocol RoomProtocol {
    func addRoom(body: RoomRequest) -> Single<RoomModel>
    func getRooms() -> Single<RoomModel>
    func joinRoom(id: Int) -> Single<EmptyResponse>
    func kickRoom(id: Int) -> Single<EmptyResponse>
    func leaveRoom() -> Single<EmptyResponse>
}
