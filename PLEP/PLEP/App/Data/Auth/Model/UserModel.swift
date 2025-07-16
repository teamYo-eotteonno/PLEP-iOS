//
//  UserModel.swift
//  PLEP
//
//  Created by 이다경 on 7/13/25.
//

import Foundation

struct UserModel: Decodable {
    let id: Int
    var email: String?
    let name: String
    let bio: String
    let photo: PhotoData?
    let createdAt: String
    let updatedAt: String
    let deletedAt: String?
}

struct PhotoData: Decodable {
    let id: String
    let path: String
}

struct otherUserModel: Decodable {
    let id: Int
    let name: String
    let photo: PhotoData?
    let bio: String
    let isFollowed: Bool
    let createdAt: String
    let updatedAt: String
    let deletedAt: String?
}
