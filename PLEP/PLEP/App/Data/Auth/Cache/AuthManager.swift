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
        if let expiresMs = AuthCache.live.getTokenExpireTime() {
            let now = Int(Date().timeIntervalSince1970)
            let expires = expiresMs / 1000
            
            if expires < now {
                print("[AuthManager] 토큰 만료. 재발급 시도")
                AuthApi().refreshToken()
                    .subscribe(
                        onSuccess: { response in
                            print("[AuthManager] 재발급 성공. 로그인 유지")
                            AuthCache.live.saveTokens(
                                Token: response.token,
                                refreshToken: response.refreshToken,
                                expires: response.tokenExpires
                            )
                        },
                        onFailure: { error in
                            print("[AuthManager] 재발급 실패. 로그아웃")
                            self.logout()
                        }
                    )
                    .disposed(by: disposeBag)
                return
            }
        }
    }
}
