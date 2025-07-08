//
//  AuthManager.swift
//  PLEP
//
//  Created by 이다경 on 7/8/25.
//

import RxSwift
import Foundation

final class AuthManager: ObservableObject {
    static let shared = AuthManager()
    
    private let disposeBag = DisposeBag()
    
    let isLoggedIn = BehaviorSubject<Bool>(value: {
        let token = AuthCache.live.getToken(of: .Token)
        return token != nil && !token!.isEmpty
    }())
    
    private init() {
        checkLoginStatus()
    }
    
    func logout() {
        AuthCache.live.clearTokens()
        isLoggedIn.onNext(false)
    }

    func loginSucceeded() {
        isLoggedIn.onNext(true)
    }
    
    func checkLoginStatus() {
        let access = AuthCache.live.getToken(of: .Token)
        let refresh = AuthCache.live.getToken(of: .refreshToken)
        let loggedIn = (access != nil && refresh != nil)
        isLoggedIn.onNext(loggedIn)
    }
}
