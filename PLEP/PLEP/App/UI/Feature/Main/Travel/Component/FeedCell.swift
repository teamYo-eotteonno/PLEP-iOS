//
//  FeedCell.swift
//  PLEP
//
//  Created by 이다경 on 6/8/25.
//

import SwiftUI

struct FeedCell: View {
    let my: Bool
    let name: String
    let intro: String
    let location: String
    let onMap: () -> Void
    let content: String
    let data: String
    var onMore: (() -> Void)?
    
    @State private var isLiked = false
    @State private var showFullContent = false
    
    var body: some View {
        VStack(spacing: 11) {
            HStack {
                HStack(spacing: 13) {
                    ProfileCell(type: .etc, size: .small, btn: false)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(name)
                            .textStyle.body.bold
                            .foregroundColor(.txt.primary)
                        Text(intro)
                            .textStyle.title.pre
                            .foregroundColor(.txt.secondary)
                            .frame(maxWidth: 220)
                            .lineLimit(1)
                    }
                }
                Spacer()
                
                if my {
                    Button(action: onMore!) {
                        Image(Asset.more)
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                } else {
                    Button(action: { isLiked.toggle() }) {
                        Image(isLiked ? Asset.Heart.tap : Asset.Heart.default)
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                }
            }
            .padding(.horizontal, 25)
            
            FeedCellImage()
            
            VStack(alignment: .leading, spacing: 11) {
                HStack(spacing: 5) {
                    ForEach(0..<3) { _ in
                        PLEPTag(
                            title: "💜ARMY",
                            type: .outlined,
                            size: .small,
                            enabled: true
                        )
                    }
                }
                
                HStack(spacing: 7) {
                    Image(Asset.Address.default)
                        .resizable()
                        .frame(width: 15, height: 15)
                    Text("위치:")
                    Button(action: onMap) {
                        Text(location)
                            .underline()
                    }
                }
                .textStyle.body.small
                .foregroundColor(.txt.tertiary)
                
                Text(content)
                    .textStyle.body.small
                    .foregroundColor(.txt.primary)
                    .lineLimit(showFullContent ? nil : 3)
                    .fixedSize(horizontal: false, vertical: true)

                if contentLineCount(content) > 3 && !showFullContent {
                    Button(action: {
                        showFullContent.toggle()
                    }) {
                        Text("더보기")
                            .textStyle.title.pre
                            .foregroundColor(.txt.secondary)
                    }
                }
                
                HStack {
                    Text(data)
                        .textStyle.title.pre
                        .foregroundColor(.txt.quartemary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 25)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 25)
        .background(Color.g[0])
    }
}

//#Preview {
//    FeedCell(my: true, name: "전정국", intro: "안녕하세요 방탄소년단 황금막내 전정국입니다.", location: "빅히트본사", content: "저희가 벌써 12주년이나 됬써요.\n고등학교를 졸업한지가 엊그제같은데 벌써 20대가 6개월밖에 남지않았습니다. ㅠㅠ 내 20대 돌리도 ㅎㅎ 암튼 제대해가지고 아미여러분 만나게 되서 너무너무너무너ㅁㅜ 기쁘구요 형들 만났는데 와 남자가 다 되써 븨형은 몸이 나랑 비슷하더라구요 그래도 제가 더 큽니다 ㅎ\n암튼 다음에 또 봐요 곧 컴백함 ㅎㅎㅎㅎㅎ 방탄소년단 파트 투!", data: "2025.06.13")
//}
