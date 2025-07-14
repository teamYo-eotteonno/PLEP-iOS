//
//  ProfileEditViewModel.swift
//  PLEP
//
//  Created by 이다경 on 7/13/25.
//

import RxSwift
import Combine
import SwiftUI

class ProfileEditViewModel: ObservableObject {
    private let disposeBag = DisposeBag()
    
    @Published var user: UserModel?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func getUser() {
        AuthApi().getMe()
            .subscribe(
                onSuccess: { [weak self] user in
                    DispatchQueue.main.async {
                        self?.user = user
                        self?.isLoading = false
                    }
                },
                onFailure: { [weak self] error in
                    DispatchQueue.main.async {
                        self?.errorMessage = error.localizedDescription
                        self?.isLoading = false
                    }
                }
            )
            .disposed(by: disposeBag)
    }
}
