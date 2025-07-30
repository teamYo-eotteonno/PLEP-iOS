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
    let onEdit: () -> Void
    @State private var isLiked = false
    @Binding var userImage: UIImage?
    let imageURL: String?

    var body: some View {
        VStack(spacing: 29) {
            HStack(spacing: 10) {
                // ① 프로필 타입 설정 (imageURL 유무로)
                let profileType: ProfileCellType = (imageURL == nil) ? .way : .custom

                ProfileCell(
                    type: profileType,
                    size: .medium,
                    btn: false,
                    image: $userImage
                )
                .onAppear {
                    if let urlString = imageURL, let url = URL(string: urlString) {
                        downloadImage(from: url) { image in
                            self.userImage = image
                        }
                    }
                }
                .onChange(of: imageURL) { newURL in
                    print("imageURL changed to: \(newURL ?? "nil")")
                    if let urlString = newURL, let url = URL(string: urlString) {
                        downloadImage(from: url) { image in
                            self.userImage = image
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 14) {
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text(name)
                                .textStyle.body.bold
                                .foregroundColor(.txt.primary)
                            Spacer()
                            if my {
                                Button(action: onEdit) {
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
                        Text("팔로워 \(followers)")
                        Text("팔로잉 \(following)")
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

    private func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
