//
//  UserCell.swift
//  PLEP
//
//  Created by 이다경 on 6/7/25.
//

import SwiftUI

enum FollowUserCellType {
    case way, loke, custom
}

struct FollowUserCell: View {
    let type: FollowUserCellType
    let Name: Bool
    var name: String?
    let imageURL: String?
    
    @State private var image: UIImage? = nil
    
    var body: some View {
        VStack(spacing: 5) {
            ProfileCell(
                type: convertToProfileCellType(type),
                size: .small,
                btn: false,
                profileImageURL: imageURL
            )
            .onAppear {
                loadImage()
            }
            .onChange(of: imageURL) { _ in
                loadImage()
            }
            
            if Name {
                Text(name ?? "")
                    .textStyle.title.pre
                    .foregroundColor(.txt.primary)
                    .frame(maxWidth: 55)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
        }
    }
    
    private func convertToProfileCellType(_ type: FollowUserCellType) -> ProfileCellType {
        switch type {
        case .way: return .way
        case .loke: return .loke
        case .custom: return .custom
        }
    }
    
    private func loadImage() {
        guard let urlString = imageURL, let url = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url),
                  let loadedImage = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = loadedImage
            }
        }
    }
}
