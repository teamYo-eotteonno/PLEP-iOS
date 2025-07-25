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

extension ScheduleModel {
    func toSchedule() -> Schedule {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        let startDate = formatter.date(from: self.startAt) ?? Date()
        let endDate = formatter.date(from: self.endAt)

        return Schedule(
            name: self.title,
            startDate: startDate,
            endDate: endDate,
            color: convertStringToColor(self.group?.color ?? "") ?? .blue
        )
    }
}
