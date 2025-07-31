//
//  ProfileFeedView.swift
//  PLEP
//
//  Created by 이다경 on 6/7/25.
//

import SwiftUI
import FlowKit

struct ProfileView: View {
    @StateObject private var userViewModel: ProfileFeedViewModel
    @State private var showEdit = false
    @State private var userImage: UIImage? = nil
    
    init(viewModel: ProfileFeedViewModel) {
        _userViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.g[0].ignoresSafeArea()
            VStack {
                if let user = userViewModel.user {
                    VStack(spacing: 20) {
                        ProfileFeedTitleCell(
                            my: true,
                            name: user.name,
                            intro: user.bio,
                            followers: userViewModel.follows?.followers ?? 0,
                            following: userViewModel.follows?.followings ?? 0,
                            onEdit: {
                                showEdit = true
                            },
                            userImage: $userImage,
                            imageURL: user.photo?.path
                        )
                        .contentShape(Rectangle())
                        .padding(.horizontal, 25)
//                        .padding(.top, 72)
                        
                        ProfileFeedView(userId: user.id)
                    }
                } else {
                    ProgressView()
                        .onAppear {
                            userViewModel.getUser()
                        }
                }
            }
            .fullScreenCover(isPresented: $showEdit) {
                ProfileEditMainView(
                    onDismiss: {
                        print("취소")
                        showEdit = false
                    }
                )
            }
            .onChange(of: userViewModel.user) { user in
                guard let user = user else { return }
                
                if let urlString = user.photo?.path,
                   let url = URL(string: urlString) {
                    URLSession.shared.dataTask(with: url) { data, _, error in
                        guard let data = data, error == nil, let image = UIImage(data: data) else { return }
                        DispatchQueue.main.async {
                            self.userImage = image
                        }
                    }.resume()
                }
                
                userViewModel.getFollows(userId: user.id)
            }
            .ignoresSafeArea()
        }
    }
}
