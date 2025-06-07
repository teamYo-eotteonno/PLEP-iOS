//
//  UserCell.swift
//  PLEP
//
//  Created by 이다경 on 6/7/25.
//

import SwiftUI

enum FollowUserCellType {
    case way, loke, etc
}

struct FollowUserCell: View {
    let type: FollowUserCellType
    let name: String
    
    var body: some View {
        VStack(spacing: 5) {
            switch type {
            case.way:
                ProfileCell(type: .way, size: .small, btn: false)
            case.loke:
                ProfileCell(type: .loke, size: .small, btn: false)
            case.etc:
                ProfileCell(type: .etc, size: .small, btn: false)
            }
            Text(name)
                .textStyle.title.pre
                .foregroundColor(.txt.primary)
                .frame(maxWidth: 55)
                .lineLimit(1)
                .truncationMode(.tail)
        }
    }
}
