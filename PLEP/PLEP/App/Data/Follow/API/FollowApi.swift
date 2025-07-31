//
//  FeedApi.swift
//  PLEP
//
//  Created by 이다경 on 7/29/25.
//

import Foundation
import RxSwift
import Alamofire

class FollowApi: FollowProtocol {
    
    func getfollow(userId: Int) -> Single<[FollowModel]> {
        return Single.create { single in
            let parameters: [String: Any] = ["userId": userId]
            let request = API.session.request(
                PLEPURL.Follow.getFollows(userId: userId),
                method: .get,
                parameters: parameters,
                encoding: URLEncoding.default
            )
            .validate()
            .responseDecodable(of: [FollowModel].self) { response in
                switch response.result {
                case .success(let followers):
                    single(.success(followers))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create {request.cancel() }
        }
        .observe(on: MainScheduler.instance)
    }
}
