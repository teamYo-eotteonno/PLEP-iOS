//
//  ProfileCell.swift
//  PLEP
//
//  Created by 이다경 on 5/9/25.
//

import SwiftUI

enum ProfileCellType {
    case way, loke, etc
}

enum ProfileCellSize {
    case small, medium, large
}

struct ProfileCell: View {
    let type: ProfileCellType
    var size: ProfileCellSize
    let btn: Bool
    
    var bgSize: CGSize {
        switch size {
        case .large:
            return CGSize(width: 200, height: 200)
        case .medium:
            return CGSize(width: 100, height: 100)
        case .small:
            return CGSize(width: 40, height: 40)
        }
    }
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ZStack {
                switch type {
                case.way:
                    Image(Asset.Way.default)
                        .resizable()
                        .frame(width: bgSize.width, height: bgSize.height)
                        .background(Color.p[200])
                        .cornerRadius(100)
                case.loke:
                    Image(Asset.Loke.default)
                        .resizable()
//                        .frame(width: 156, height: 160.5)
                        .frame(width: bgSize.width, height: bgSize.height)
                        .background(Color.p[600])
                        .cornerRadius(100)
                case.etc:
                    Image("Dummy1")
                        .resizable()
                        .frame(width: bgSize.width, height: bgSize.height)
                        .clipShape(Circle())
                }
            }
            if btn {
                Button(action: {}) {
                    Image(Asset.camera)
                        .resizable()
                        .frame(width: size == .medium ? 15 : 24, height: size == .medium ? 15 : 24)
                        .frame(width: size == .medium ? 22 : 44, height: size == .medium ? 22 : 44)
                        .background(Color.p[300])
                        .cornerRadius(50)
                }
            }
        }
    }
}
