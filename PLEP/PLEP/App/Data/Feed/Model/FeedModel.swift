//
//  FeedModel.swift
//  PLEP
//
//  Created by 이다경 on 7/29/25.
//

import Foundation

struct FeedResponse: Decodable {
    let data: [FeedModel]
    let hasNextPage: Bool
}

struct FeedModel: Decodable, Identifiable {
    let id: Int
    let photos: [FileModel]
    let placeId: String
    let placeName: String
    let context: String
    let user: otherUserModel
    let categories: [String]
    let createdAt: String
    let updatedAt: String
    let deletedAt: String?
}
