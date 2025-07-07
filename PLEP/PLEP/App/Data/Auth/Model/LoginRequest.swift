//
//  LoginRequest.swift
//  PLEP
//
//  Created by 이다경 on 7/7/25.
//

import Foundation

struct LoginRequest: Encodable {
    let email: String
    let password: String
}
