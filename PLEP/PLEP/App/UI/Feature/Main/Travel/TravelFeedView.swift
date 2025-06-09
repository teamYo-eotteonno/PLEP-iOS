//
//  TravelFeedView.swift
//  PLEP
//
//  Created by 이다경 on 6/9/25.
//

import SwiftUI

struct TravelFeedView: View {
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
                    
                    ForEach(0..<8) { _ in
                        VStack(spacing: 0) {
                            Rectangle()
                                .frame(maxWidth: .infinity)
                                .frame(height: 10)
                                .foregroundColor(.g[50])
                            FeedCell(
                                my: true,
                                name: "전정국",
                                intro: "안녕하세요 방탄소년단 황금막내 전정국입니다.",
                                location: "빅히트본사",
                                onMap: {},
                                content: "저희가 벌써 12주년이나 됬써요.\n고등학교를 졸업한지가 엊그제같은데 벌써 20대가 6개월밖에 남지않았습니다. ㅠㅠ 내 20대 돌리도 ㅎㅎ 암튼 제대해가지고 아미여러분 만나게 되서 너무너무너무너ㅁㅜ 기쁘구요 형들 만났는데 와 남자가 다 되써 븨형은 몸이 나랑 비슷하더라구요 그래도 제가 더 큽니다 ㅎ\n암튼 다음에 또 봐요 곧 컴백함 ㅎㅎㅎㅎㅎ 방탄소년단 파트 투!",
                                data: "2025.06.13",
                                onMore: { showMoreSheet.toggle() }
                            )
                        }
                    }
                }
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
    }
}

#Preview {
    TravelFeedView()
}
