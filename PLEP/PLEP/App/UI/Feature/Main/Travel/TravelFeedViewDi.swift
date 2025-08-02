//
//  TravelFeedViewDi.swift
//  PLEP
//
//  Created by 이다경 on 8/2/25.
//

import SwiftUI

struct TravelFeedViewDi {
    var travelfeedView: some View {
        TravelFeedView(
            viewModel: travelfeedViewModel,
            userviewModel: profileEditViewModel
        )
    }

    private var travelfeedViewModel: TravelFeedViewModel {
        TravelFeedViewModel()
    }

    private var profileEditViewModel: ProfileEditViewModel {
        ProfileEditViewModel()
    }
}
