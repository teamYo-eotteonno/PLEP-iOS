//
//  FollowUsersList.swift
//  PLEP
//
//  Created by 이다경 on 6/7/25.
//

import SwiftUI

struct FollowUsersList: View {
    let followings: [otherUserModel]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack(spacing: 10) {
                Text("내가 팔로우한 인물")
                    .textStyle.body.small
                    .foregroundColor(.txt.primary)
                Text(String(followings.count))
                + Text("명")
            }
            .textStyle.title.pre
            .foregroundColor(.p[500])
            
            if followings.isEmpty {
                Text("아직 팔로우한 유저가 없습니다!\n관심있는 유저를 팔로우해보세요.")
                    .textStyle.title.pre
                    .foregroundColor(.txt.tertiary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 23)
                    .background(Color.g[50])
                    .cornerRadius(15)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(followings, id: \.id) { user in
                            FollowUserCell(
                                type: .custom,
                                Name: true,
                                name: user.name,
                                image: .constant(nil)
                            )
                        }
                    }
                }
            }
        }
        .padding(.vertical, 15)
        .background(Color.g[0])
    }
}
