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
    let onCreate: () -> Void
    @State private var isLiked = false
    @State private var userImage: UIImage? = nil
    let imageURL: String?
    
    var body: some View {
        VStack(spacing: 29) {
            HStack(spacing: 10) {
                let profileType: ProfileCellType = (imageURL == nil) ? .way : .custom
                
                ProfileCell(
                    type: profileType,
                    size: .medium,
                    btn: false,
                    profileImageURL: imageURL
                )
                .onAppear {
                    loadImage()
                }
                .onChange(of: imageURL) { _ in
                    loadImage()
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
                    action: onCreate
                )
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private func loadImage() {
        guard let urlString = imageURL, let url = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url),
                  let loadedImage = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.userImage = loadedImage
            }
        }
    }
}
