//
//  EditListCell.swift
//  PLEP
//
//  Created by 이다경 on 6/7/25.
//

import SwiftUI

enum EdithListCellType {
    case profile, setting
}

struct EditListCell: View {
    var type: EdithListCellType
    var name: String?
    var intro: String?
    var email: String?
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                switch type {
                case.profile:
                    Text("내프로필")
                case.setting:
                    Text("설정")
                }
            }
            .textStyle.body.bold
            .foregroundColor(.txt.primary)
            .padding(.horizontal, 16)
            .padding(.vertical, 15)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.g[100])
            
            VStack(spacing: 0) {
                ForEach(itemsForType(), id: \.self) { title in
                    VStack(spacing: 0) {
                        HStack {
                            Text(title)
                                .lineLimit(1)
                            Spacer()
                            PLEPButton(
                                title: "수정",
                                type: .neutral,
                                size: .small,
                                enabled: true,
                                action: {}
                            )
                            .frame(width: 70)
                        }
                        .textStyle.body.default
                        .foregroundColor(.txt.tertiary)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        
                        if title != itemsForType().last {
                            PLEPDivider(type: .g300)
                        }
                    }
                }
            }
        }
        .background(Color.g[0])
        .cornerRadius(10)
    }
    
    func itemsForType() -> [String] {
        switch type {
        case .profile:
            return [name!, intro!]
        case .setting:
            return [maskEmail(email!), "아이디", "비밀번호"]
        }
    }
}
