//
//  GroupModel.swift
//  PLEP
//
//  Created by 이다경 on 7/15/25.
//

import Foundation

struct GroupModel: Decodable, Identifiable {
    let id: Int
    let name: String
    let color: String
    let createdAt: String
    let updatedAt: String
    let deletedAt: String?
}
