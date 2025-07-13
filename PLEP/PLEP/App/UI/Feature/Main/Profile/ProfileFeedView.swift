//
//  ProfileFeedView.swift
//  PLEP
//
//  Created by 이다경 on 6/7/25.
//

import SwiftUI
import FlowKit

struct ProfileFeedView: View {
    @Flow var flow
    let name: String
    let intro: String
    let followers: Int
    let following: Int
    let null: Bool
    
    private let gridItems: [GridItem] = [
            .init(.flexible(), spacing: 1),
            .init(.flexible(), spacing: 1),
            .init(.flexible(), spacing: 1)
        ]
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(spacing: 0) {
                    ProfileFeedTitleCell(
                        my: true,
                        name: name,
                        intro: intro,
                        followers: followers,
                        following: following,
                        onEdit: { flow.push(ProfileEditMainView(name: name, intro: intro, email: "ab@gmail.com")) }
                    )
                    FollowUsersList(follow: 10)
                }
                .padding(.horizontal, 25)
                .padding(.top, 72)
                .background(Color.g[0])
                
                VStack {
                    if !null {
                        LazyVGrid(columns: gridItems, spacing: 1) {
                            ForEach(0..<20) { feed in
                                
                                NavigationLink {
                                    Image("Dummy3")
                                        .resizable()
                                        .scaledToFit()
                                } label: {
                                    Image("Dummy3")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 125, height: 125)
                                        .clipped()
                                }
                            }
                        }
                        .frame(height: UIScreen.main.bounds.height)

                    } else {
                        VStack(spacing: 30) {
                            Image(Asset.Feed.add)
                                .resizable()
                                .frame(width: 60, height: 60)
                            Text("추가된 피드가 없습니다!\n피드를 추가하러 가보세요!")
                                .textStyle.body.default
                                .foregroundColor(.txt.tertiary)
                            PLEPButton(
                                title: "피드 추가하러 가기",
                                type: .neutral,
                                size: .small,
                                enabled: true,
                                icon: Asset.Arrow.left,
                                action: {}
                            )
                            .frame(width: 183)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 72)
                        .background(Color.g[100])
                        .cornerRadius(20)
                        .padding(.horizontal, 25)
                    }
                }
                .padding(.vertical, 20)
            }
        }
        .background(Color.g[50])
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

//#Preview {
//    ProfileFeedView(name: "전정국", intro: "안녕하세요 저는 방탄소년단 황금막내 전정국입니다", followers: 10, following: 10, null: false)
//}
