//
//  FeedRequest.swift
//  PLEP
//
//  Created by 이다경 on 7/29/25.
//

import Foundation

struct FeedRequest: Encodable {
    let placeId: String
    let placeName: String
    let placeAddress: String
    let photoIds: [String]
    let context: String
    let categories: [String]
}
