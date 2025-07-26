//
//  UserCell.swift
//  PLEP
//
//  Created by 이다경 on 6/7/25.
//

import SwiftUI

enum FollowUserCellType {
    case way, loke, custom
}

struct FollowUserCell: View {
    let type: FollowUserCellType
    let Name: Bool
    var name: String?
    @Binding var image: UIImage?
    
    var body: some View {
        VStack(spacing: 5) {
            ProfileCell(
                type: convertToProfileCellType(type),
                size: .small,
                btn: false,
                image: $image
            )
            Rectangle()
            
            if Name == true {
                Text(name ?? "")
                    .textStyle.title.pre
                    .foregroundColor(.txt.primary)
                    .frame(maxWidth: 55)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
        }
    }
    
    private func convertToProfileCellType(_ type: FollowUserCellType) -> ProfileCellType {
        switch type {
        case .way: return .way
        case .loke: return .loke
        case .custom: return .custom
        }
    }
}
