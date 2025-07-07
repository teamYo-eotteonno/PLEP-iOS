//
//  LoginViewModel.swift
//  PLEP
//
//  Created by 이다경 on 6/25/25.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class LoginViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var loginResult: LoginModel?
    @Published var errorMessage: String?

    private let disposeBag = DisposeBag()
    private let api: AuthProtocol

    init(api: AuthProtocol) {
        self.api = api
    }

    func login(email: String, password: String) {
        self.isLoading = true
        self.errorMessage = nil

        let body = LoginRequest(
            email: email,
            password: password
        )

        api.login(body: body)
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] response in
                self?.isLoading = false
                self?.loginResult = response.value
                print("로그인 성공: \(String(describing: response.value))")
            } onFailure: { [weak self] error in
                self?.isLoading = false
                self?.errorMessage = error.localizedDescription
                print("로그인 실패: \(error.localizedDescription)")
            }
            .disposed(by: disposeBag)
    }
}
