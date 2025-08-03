//
//  ProfileCell.swift
//  PLEP
//
//  Created by 이다경 on 5/9/25.
//

import SwiftUI

enum ProfileCellType: String, Codable {
    case way, loke, custom
}

enum ProfileCellSize {
    case small, medium, large
}

struct ProfileCell: View {
    let type: ProfileCellType
    var size: ProfileCellSize
    let btn: Bool
    var onButtonTap: (() -> Void)? = nil
    var profileImageURL: String? = nil
    
    var inputImage: UIImage? = nil
    
    @State private var image: UIImage? = nil
    
    var bgSize: CGSize {
        switch size {
        case .large: return CGSize(width: 200, height: 200)
        case .medium: return CGSize(width: 100, height: 100)
        case .small: return CGSize(width: 40, height: 40)
        }
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ZStack {
                switch type {
                case .way:
                    Image(Asset.Way.default)
                        .resizable()
                        .frame(width: bgSize.width, height: bgSize.height)
                        .background(Color.p[200])
                        .cornerRadius(100)
                case .loke:
                    Image(Asset.Loke.default)
                        .resizable()
                        .frame(width: bgSize.width, height: bgSize.height)
                        .background(Color.p[600])
                        .cornerRadius(100)
                case .custom:
                    if let img = inputImage ?? image {
                        Image(uiImage: img)
                            .resizable()
                            .frame(width: bgSize.width, height: bgSize.height)
                            .clipShape(Circle())
                    } else {
                        Circle()
                            .fill(Color.gray)
                            .frame(width: bgSize.width, height: bgSize.height)
                    }
                }
            }
            if btn {
                Button(action: { onButtonTap?() }) {
                    Image(Asset.camera)
                        .resizable()
                        .frame(width: size == .medium ? 15 : 24, height: size == .medium ? 15 : 24)
                        .frame(width: size == .medium ? 22 : 44, height: size == .medium ? 22 : 44)
                        .background(Color.p[300])
                        .cornerRadius(50)
                }
            }
        }
        .onAppear {
            loadProfileImage()
        }
    }

    private func loadProfileImage() {
        guard let urlString = profileImageURL, let url = URL(string: urlString) else { return }

        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let loadedImage = UIImage(data: data) {
                    await MainActor.run {
                        self.image = loadedImage
                    }
                }
            } catch {
                print("프로필 이미지 로딩 실패: \(error)")
            }
        }
    }
}
