//
//  LoginModel.swift
//  PLEP
//
//  Created by 이다경 on 7/7/25.
//

import Foundation

struct LoginModel: Decodable {
    let refreshToken: String
    let token: String
    let tokenExpires: Int
    let user: UserModel
}

struct UserModel: Decodable {
    let id: Int
    let email: String
    let name: String
    let bio: String
    let createdAt: String
    let updatedAt: String
    let deletedAt: String?
}
