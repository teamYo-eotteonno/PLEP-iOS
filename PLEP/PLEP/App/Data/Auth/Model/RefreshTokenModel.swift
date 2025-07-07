//
//  RefreshTokenModel.swift
//  PLEP
//
//  Created by 이다경 on 7/7/25.
//

import Foundation

struct RefreshTokenRequest: Encodable {
    let token: String
}

struct RefreshTokenResponse: Decodable {
    let token: String
    let refreshToken: String
    let tokenExpires: Int
}
