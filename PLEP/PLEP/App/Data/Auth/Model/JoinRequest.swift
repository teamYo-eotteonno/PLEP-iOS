//
//  JoinRequest.swift
//  PLEP
//
//  Created by 이다경 on 7/7/25.
//

import Foundation

struct JoinRequest: Encodable {
    let email: String
    let password: String
    let name: String
    let bio: String
    let code: String
}
