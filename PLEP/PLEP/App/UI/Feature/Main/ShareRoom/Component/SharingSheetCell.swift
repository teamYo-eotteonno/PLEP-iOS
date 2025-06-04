//
//  SharingSheetCell.swift
//  PLEP
//
//  Created by 이다경 on 6/4/25.
//

import SwiftUI

struct SharingSheetCell: View {
    let type: SharingSheetCellType
    let action: () -> Void
    
    private var style: SharingSheetCellStyle {
        SharingSheetCellStyle(type: type)
    }
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 3) {
                Image(style.img)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                Text(style.title)
                    .textStyle.body.default
                    .foregroundColor(.txt.primary)
            }
        }
    }
}
