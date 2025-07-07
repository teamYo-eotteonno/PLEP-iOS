//
//  LoginViewDi.swift
//  PLEP
//
//  Created by 이다경 on 7/7/25.
//

import SwiftUI

struct LoginViewDi {
    var loginView: some View {
        LoginFirstView(viewModel: loginViewModel)
    }

    private var loginViewModel: LoginViewModel {
        LoginViewModel(api: AuthApi())
    }
}
