//
//  TravelFeedView.swift
//  PLEP
//
//  Created by 이다경 on 6/9/25.
//

import SwiftUI
import FlowKit

struct TravelFeedView: View {
    @Flow var flow
    @StateObject private var viewModel = TravelFeedViewModel()
    @State private var showMoreSheet = false
    @State private var search = ""

    var body: some View {
        ZStack {
            Color.g[0].ignoresSafeArea()
            ScrollView {
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        if search.isEmpty {
                            FollowUsersList(follow: 10)
                        }
                        FeedSearch(search: $search)
                    }
                    .padding(.horizontal, 25)

                    ForEach(viewModel.feeds) { feed in
                        VStack(spacing: 0) {
                            Rectangle()
                                .frame(maxWidth: .infinity)
                                .frame(height: 10)
                                .foregroundColor(.g[50])
                            
                            FeedCell(
                                my: (feed.user.id != 0),
                                name: feed.user.name,
                                intro: feed.user.bio,
                                location: feed.placeName,
                                onMap: {},
                                content: feed.context,
                                data: formatDate(feed.createdAt),
                                tags: feed.categories,
                                imageUrls: feed.photos.map { $0.path },
                                profileImageURL: feed.user.photo?.path ?? "",
                                onMore: { showMoreSheet.toggle() }
                            )
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchFeeds()
            }
            .sheet(isPresented: $showMoreSheet) {
                ZStack {
                    Color.g[0]
                        .cornerRadius(20)
                        .shadow(radius: 5)

                    VStack(spacing: 0) {
                        Capsule()
                            .foregroundColor(.g[500])
                            .frame(width: 64, height: 1)
                            .padding(.vertical, 20)

                        TravelMoreSheet(onEdit: {}, onDelete: {})
                    }
                }
                .presentationDetents([.fraction(0.2)])
                .presentationDragIndicator(.hidden)
            }
        }
        .padding(.top, 72)
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }

    private func formatDate(_ isoDate: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: isoDate) {
            let output = DateFormatter()
            output.dateFormat = "yyyy.MM.dd"
            return output.string(from: date)
        }
        return ""
    }
}
