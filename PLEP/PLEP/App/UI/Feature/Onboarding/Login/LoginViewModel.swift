//
//  LoginViewModel.swift
//  PLEP
//
//  Created by 이다경 on 6/25/25.
//

//import Foundation
//import RxSwift
//import RxCocoa
//
//class LoginViewModel: ObservableObject {
//    let email = BehaviorRelay<String>(value: "")
//    let password = BehaviorRelay<String>(value: "")
//    let loginTapped = PublishRelay<Void>()
//
//    @Published var isLoginEnabled = false
//    @Published var loginSuccess = false
//
//    private let disposeBag = DisposeBag()
//
//    init() {
//        Observable.combineLatest(email, password)
//            .map { !$0.0.isEmpty && !$0.1.isEmpty }
//            .bind(to: \.isLoginEnabled, on: self)
//            .disposed(by: disposeBag)
//
//        loginTapped
//            .withLatestFrom(Observable.combineLatest(email, password))
//            .flatMapLatest { email, password -> Observable<Bool> in
//                return AuthService.login(email: email, password: password)
//            }
//            .bind(to: \.loginSuccess, on: self)
//            .disposed(by: disposeBag)
//    }
//}
