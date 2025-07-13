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
    
    func getUser() {
        AuthApi().getMe()
            .subscribe(onSuccess: { [weak self] user in
                DispatchQueue.main.async {
                    self?.user = user
                }
            }, onFailure: { error in
                print("유저 정보 조회 실패: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
}
