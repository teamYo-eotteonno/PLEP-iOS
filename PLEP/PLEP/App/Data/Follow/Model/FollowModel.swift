//
//  FeedModel.swift
//  PLEP
//
//  Created by 이다경 on 7/29/25.
//

import Foundation

//struct FollowResponse: Decodable {
//    let data: [FeedModel]
//    let hasNextPage: Bool
//}

struct FollowModel: Decodable {
    let followers: Int
    let followings: Int
}
