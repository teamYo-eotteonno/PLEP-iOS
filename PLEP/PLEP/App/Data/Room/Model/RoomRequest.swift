//
//  RoomRequest.swift
//  PLEP
//
//  Created by 이다경 on 7/16/25.
//

import Foundation

struct RoomRequest: Encodable {
    let title: String
    let categories: [String]
}
