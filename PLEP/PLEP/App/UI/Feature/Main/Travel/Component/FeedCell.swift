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
    let tags: [String]
    let imageUrls: [String]
    let profileImageURL: String?
    var onMore: (() -> Void)?
    
    @State private var isLiked = false
    @State private var showFullContent = false
    @State private var userImage: UIImage? = nil
    
    var body: some View {
        VStack(spacing: 11) {
            HStack {
                HStack(spacing: 13) {
                    ProfileCell(type: .way, size: .small, btn: false, image: $userImage)
                        .onAppear {
                            loadProfileImage()
                        }

                    VStack(alignment: .leading, spacing: 5) {
                        Text(name)
                            .textStyle.body.bold
                            .foregroundColor(.txt.primary)
                        Text(intro)
                            .textStyle.title.pre
                            .foregroundColor(.txt.secondary)
                            .frame(maxWidth: 220, alignment: .leading)
                            .lineLimit(1)
                    }
                }
                Spacer()
                
                if my {
                    Button(action: onMore ?? {}) {
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
            
            FeedCellImage(
                imagePaths: imageUrls,
                isEditable: false
            )

            VStack(alignment: .leading, spacing: 11) {
                if !tags.isEmpty {
                    HStack(spacing: 5) {
                        ForEach(tags.prefix(3), id: \.self) { tag in
                            PLEPTag(
                                title: tag,
                                type: .outlined,
                                size: .small,
                                enabled: true
                            )
                        }
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

    private func loadProfileImage() {
        guard let urlString = profileImageURL, let url = URL(string: urlString) else { return }
        Task {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                userImage = image
            }
        }
    }
}
