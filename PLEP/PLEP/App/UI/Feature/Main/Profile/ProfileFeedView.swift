//
//  ProfileFeedView.swift
//  PLEP
//
//  Created by 이다경 on 6/7/25.
//

import SwiftUI

struct ProfileFeedView: View {
    var userId: Int?
    
    @StateObject private var viewModel = ProfileFeedViewModel()
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if !viewModel.feeds.isEmpty {
                LazyVGrid(columns: gridItems, spacing: 1) {
                    ForEach(viewModel.feeds, id: \.id) { feed in
                        NavigationLink {
                            RemoteImageView(urlString: feed.photos.first?.path ?? "")
                                .scaledToFit()
                        } label: {
                            RemoteImageView(urlString: feed.photos.first?.path ?? "")
                                .scaledToFill()
                                .frame(width: 125, height: 125)
                                .clipped()
                        }
                    }
                }
            } else {
                VStack(spacing: 30) {
                    Image(Asset.Feed.add)
                        .resizable()
                        .frame(width: 60, height: 60)
                    Text("추가된 피드가 없습니다!\n피드를 추가하러 가보세요!")
                        .textStyle.body.default
                        .foregroundColor(.txt.tertiary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 72)
                .background(Color.g[100])
                .cornerRadius(20)
                .padding(.horizontal, 25)
            }
        }
        .onAppear {
            viewModel.getFeeds(userId: userId ?? 0)
        }
        .background(Color.g[50])
    }
}
