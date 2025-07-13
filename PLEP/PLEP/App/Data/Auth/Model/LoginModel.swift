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
