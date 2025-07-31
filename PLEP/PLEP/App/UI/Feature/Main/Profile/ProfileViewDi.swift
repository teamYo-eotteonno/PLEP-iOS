//
//  ProfileViewDi.swift
//  PLEP
//
//  Created by 이다경 on 7/31/25.
//

import Foundation
import SwiftUI

struct ProfileViewDi {
    var profileView: some View {
        ProfileView(viewModel: profileViewModel)
    }

    private var profileViewModel: ProfileFeedViewModel {
        ProfileFeedViewModel()
    }
}
