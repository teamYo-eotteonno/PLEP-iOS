//
//  FeedApi.swift
//  PLEP
//
//  Created by 이다경 on 7/29/25.
//

import Foundation
import RxSwift
import Alamofire

class FeedApi: FeedProtocol {
    
    func addFeed(body: FeedRequest) -> Single<EmptyResponse> {
        return Single.create { single in
            let request = API.session.request(
                PLEPURL.Feeds.addFeeds,
                method: .post,
                parameters: body,
                encoder: JSONParameterEncoder.default
            )
                .validate()
                .responseDecodable(of: EmptyResponse.self) { response in
                    switch response.result {
                    case .success(let feed):
                        single(.success(feed))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            
            return Disposables.create { request.cancel()
            }
        }
        .observe(on: MainScheduler.instance)
    }
    
    func getFeeds() -> Single<FeedResponse> {
        return Single.create { single in
            let request = API.session.request(
                PLEPURL.Feeds.getFeeds,
                method: .get
            )
            .validate()
            .responseDecodable(of: FeedResponse.self) { response in
                switch response.result {
                case .success(let feedResponse):
                    single(.success(feedResponse))
                case .failure(let error):
                    single(.failure(error))
                }
            }

            return Disposables.create { request.cancel() }
        }
        .observe(on: MainScheduler.instance)
    }
}
