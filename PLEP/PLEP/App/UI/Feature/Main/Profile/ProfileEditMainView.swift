//
//  ProfileEditMainView.swift
//  PLEP
//
//  Created by 이다경 on 6/6/25.
//

import SwiftUI
import FlowKit

struct ProfileEditMainView: View {
    @Flow var flow
    var onDismiss: (() -> Void)? = nil
    @State var userImage: UIImage? = nil

    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ProfileEditViewModel()

    var body: some View {
        ZStack {
            Color.g[50].ignoresSafeArea()

            VStack(spacing: 0) {
                PLEPTopbar(type: .default, action: {
                    flow.pop()
                    onDismiss?()
                })

                if let user = viewModel.user {
                    let profileType: ProfileCellType = (user.photo?.path == nil) ? .way : .custom

                    VStack(spacing: 19) {
                        ProfileCell(type: profileType, size: .medium, btn: true, onButtonTap: {}, image: $userImage)

                        VStack(spacing: 5) {
                            Text(user.name)
                                .textStyle.body.bold
                                .foregroundColor(.txt.primary)
                            Text(user.bio)
                                .textStyle.title.pre
                                .foregroundColor(.txt.tertiary)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.vertical, 30)
                    .background(Color.g[0])

                    VStack(spacing: 23) {
                        EditListCell(type: .profile, name: user.name, intro: user.bio)
                        EditListCell(type: .setting, email: user.email)
                        Spacer()
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 23)
                } else {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.getUser()
        }
        .onChange(of: viewModel.user) { user in
            guard let urlString = user?.photo?.path,
                  let url = URL(string: urlString) else { return }

            downloadImage(from: url) { image in
                self.userImage = image
            }
        }
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
