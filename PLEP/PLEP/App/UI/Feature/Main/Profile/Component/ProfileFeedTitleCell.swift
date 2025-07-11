//
//  ProfileFeedTitle.swift
//  PLEP
//
//  Created by 이다경 on 6/7/25.
//

import SwiftUI

struct ProfileFeedTitleCell: View {
    let my: Bool
    let name: String
    let intro: String
    let followers: Int
    let following: Int
    @State private var isLiked = false
    
    var body: some View {
        VStack(spacing: 29) {
            HStack(spacing: 10) {
//                ProfileCell(type: .loke, size: .medium, btn: false)
                VStack(alignment: .leading, spacing: 14) {
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text(name)
                                .textStyle.body.bold
                                .foregroundColor(.txt.primary)
                            Spacer()
                            if my {
                                Button(action: {}) {
                                    Image(Asset.setting)
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                }
                            } else {
                                Button(action: { isLiked.toggle() }) {
                                    Image(isLiked ? Asset.Heart.tap : Asset.Heart.default)
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                }
                            }
                        }
                        Text(intro)
                            .textStyle.body.small
                            .foregroundColor(.txt.secondary)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack(spacing: 14) {
                        Text("팔로워 "+String(followers))
                        Text("팔로잉 "+String(following))
                    }
                    .textStyle.title.pre
                    .foregroundColor(.txt.quartemary)
                }
                .padding(.horizontal, 8)
            }
            if my {
                PLEPButton(
                    title: "피드생성",
                    type: .filled,
                    size: .small,
                    enabled: true,
                    icon: Asset.plus,
                    action: {}
                )
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
    }
}
