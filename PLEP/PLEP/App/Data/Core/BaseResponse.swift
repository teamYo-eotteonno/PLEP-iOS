//
//  BaseResponse.swift
//  PLEP
//
//  Created by 이다경 on 7/7/25.
//

import Foundation

struct EmptyResponse: Decodable {}

struct ErrorResponse: Decodable {
    let status: Int
    let errors: [String: String]
}

struct SecondErrorReason: Decodable {
    let message: String
    let statusCode: Int
}
