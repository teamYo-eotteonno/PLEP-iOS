//
//  TimetableModel.swift
//  PLEP
//
//  Created by 이다경 on 7/16/25.
//

import Foundation

struct TimetableModel: Decodable {
    let id: Int
    var schedule: ScheduleModel?
    let placeId: String
    let placeName: String
    let placeAddress: String
    let title: String
    let memo: String
    let dateAt: String
    let checked: Bool
    let createdAt: String
    let updatedAt: String
    let deletedAt: String?
}
