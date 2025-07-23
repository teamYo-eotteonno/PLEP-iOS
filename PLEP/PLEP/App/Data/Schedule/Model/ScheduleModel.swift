//
//  ScheduleModel.swift
//  PLEP
//
//  Created by 이다경 on 7/16/25.
//

import Foundation

struct ScheduleModel: Decodable {
    let id: Int
    var group: GroupModel?
    let title: String
    let startAt: String
    let endAt: String
    let createdAt: String
    let updatedAt: String
    let deletedAt: String?
}

struct ScheduleListModel: Decodable {
    let data: [ScheduleModel]
}
