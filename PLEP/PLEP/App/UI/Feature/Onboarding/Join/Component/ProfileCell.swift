//
//  ProfileCell.swift
//  PLEP
//
//  Created by 이다경 on 5/9/25.
//

import SwiftUI

struct ProfileCell: View {
    var type: ProfileCellType

    private var style: ProfileCellStyle {
        ProfileCellStyle(type: type)
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ZStack {
                Circle()
                    .frame(width: 200)
                    .foregroundColor(style.bgcColor)
                Image(style.imageName)
                    .resizable()
                    .frame(width: type == .loke ? 156 : 180, height: type == .loke ? 160.5 : 180)
            }
            Button(action: {}) {
                ZStack {
                    Circle()
                        .frame(width: 44)
                        .foregroundColor(.p[300])
                    Image(Asset.camera)
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            }
        }
    }
}

#Preview {
    ProfileCell(type: .way)
}
