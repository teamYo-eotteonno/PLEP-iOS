//
//  ScheduleCellMore.swift
//  PLEP
//
//  Created by 이다경 on 6/18/25.
//

import SwiftUI

struct ScheduleCellMore: View {
    let onEdit: () -> Void
    let onDelete: () -> Void
    var body: some View {
        VStack(spacing: 10) {
            Button(action: onEdit) {
                Text("수정")
                    .padding(.horizontal, 8)
                    .padding(.vertical, 7)
            }
            Button(action: onDelete) {
                Text("삭제")
                    .padding(.horizontal, 8)
                    .padding(.vertical, 7)
            }
        }
        .textStyle.body.default
        .foregroundColor(.txt.tertiary)
        .padding(10)
        .background(Color.g[0])
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.g[300], lineWidth: 1)
        )
    }
}
