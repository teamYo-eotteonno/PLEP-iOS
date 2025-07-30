//
//  FeedProtocol.swift
//  PLEP
//
//  Created by 이다경 on 7/29/25.
//

import Foundation
import RxSwift
import Alamofire

protocol FeedProtocol {
    func addFeed(body: FeedRequest) -> Single<EmptyResponse>
    func getFeeds() -> Single<FeedResponse>
    func getFeeds(userId: Int) -> Single<FeedResponse>
}
