//
//  ScheduleRequest.swift
//  PLEP
//
//  Created by 이다경 on 7/16/25.
//

import Foundation

struct ScheduleRequest: Encodable {
    let title: String
    let startAt: String
    let endAt: String
}
