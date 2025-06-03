//
//  MemberCell.swift
//  PLEP
//
//  Created by 이다경 on 6/2/25.
//

import SwiftUI

struct MemberListCell: View {
    let name: String
    let description: String
    let me: Bool
    var action: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 0) {
                if me {
                    Image(Asset.crown)
                        .resizable()
                        .frame(width: 15, height: 15)
                        .padding(.trailing, 5)
                }
                Text(name)
                    .textStyle.body.bold
                    .foregroundColor(.txt.primary)
                if !me {
                    Spacer()
                    Button(action: { action }) {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .foregroundColor(.icon.quartemary)
                    }
                }
            }
            Text(description)
                .textStyle.body.small
                .foregroundColor(.txt.tertiary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
        .background(Color.g[0])
        .cornerRadius(10)
    }
}
