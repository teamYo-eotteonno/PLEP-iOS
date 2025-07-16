//
//  TimetableRequest.swift
//  PLEP
//
//  Created by 이다경 on 7/16/25.
//

import Foundation

struct TimetableRequest: Encodable {
    let placeId: String
    let placeName: String
    let placeAddress: String
    let title: String
    let memo: String
    let dateAt: String
}
