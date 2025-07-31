//
//  FeedProtocol.swift
//  PLEP
//
//  Created by 이다경 on 7/29/25.
//

import Foundation
import RxSwift
import Alamofire

protocol FollowProtocol {
    func getfollow(userId: Int) -> Single<[FollowModel]>
}
