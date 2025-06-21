//
//  Schedule.swift
//  PLEP
//
//  Created by 이다경 on 6/20/25.
//

import SwiftUI

struct Schedule: Identifiable {
    let id = UUID()
    let name: String
    let startDate: Date
    var endDate: Date? = nil
    var color: Color = .blue
}
