//
//  RoomModel.swift
//  PLEP
//
//  Created by 이다경 on 7/16/25.
//

import Foundation

struct RoomModel: Decodable {
    let id: Int
    var owner: UserModel?
    let ownerId: Int
    var members: [otherUserModel]?
    let title: String
    let categories: [String]
    let createdAt: String
    let updatedAt: String
    let deletedAt: String?
}
