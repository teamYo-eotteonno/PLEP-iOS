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
                    VStack(spacing: 19) {
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
    }
}
