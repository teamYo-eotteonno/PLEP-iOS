//
//  ProfileFeedView.swift
//  PLEP
//
//  Created by 이다경 on 6/7/25.
//

import SwiftUI
import FlowKit

struct ProfileView: View {
    @StateObject private var userViewModel = ProfileFeedViewModel()
    @State private var showEdit = false
    @State private var userImage: UIImage? = nil

    var body: some View {
        VStack {
            if let user = userViewModel.user {
                ProfileFeedTitleCell(
                    my: true,
                    name: user.name,
                    intro: user.bio,
                    followers: 10,
                    following: 10,
                    onEdit: { showEdit = true },
                    userImage: $userImage,
                    imageURL: user.photo?.path
                )
                .padding(.horizontal, 25)
                .padding(.top, 72)

                ProfileFeedView(userId: user.id)
                    .padding(.horizontal, 25)
            } else {
                ProgressView()
                    .onAppear {
                        userViewModel.getUser()
                    }
            }
        }
        .fullScreenCover(isPresented: $showEdit) {
            ProfileEditMainView(
                onDismiss: { showEdit = false }
            )
        }
        .onChange(of: userViewModel.user) { user in
            guard let urlString = user?.photo?.path,
                  let url = URL(string: urlString) else { return }

            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.userImage = image
                }
            }.resume()
        }
        .background(Color.g[50])
        .edgesIgnoringSafeArea(.all)
    }
}
