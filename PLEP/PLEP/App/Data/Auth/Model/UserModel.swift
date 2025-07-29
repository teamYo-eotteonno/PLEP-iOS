//
//  UserModel.swift
//  PLEP
//
//  Created by 이다경 on 7/13/25.
//

import Foundation

struct UserModel: Decodable, Equatable {
    let id: Int
    var email: String?
    let name: String
    let bio: String
    let photo: FileModel?
    let createdAt: String
    let updatedAt: String
    let deletedAt: String?
}

struct otherUserModel: Decodable {
    let id: Int
    let name: String
    var photo: FileModel?
    let bio: String
    var isFollowed: Bool?
    let createdAt: String
    let updatedAt: String
    let deletedAt: String?
}
