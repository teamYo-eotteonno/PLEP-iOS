//
//  AuthInterceptor.swift
//  PLEP
//
//  Created by 이다경 on 7/13/25.
//

import Foundation
import Alamofire
import RxSwift

final class AuthInterceptor: RequestInterceptor {
    
    static var isRefreshing = false
    static let retrySubject = PublishSubject<Void>()
    private let disposeBag = DisposeBag()
    private let retryLimit = 1
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        
        let now = Int(Date().timeIntervalSince1970)
        if let expiresMs = AuthCache.live.getTokenExpireTime() {
            let expires = expiresMs / 1000
            
            if expires < now {
                if !AuthInterceptor.isRefreshing {
                    AuthInterceptor.isRefreshing = true
                    
                    AuthApi().refreshToken()
                        .observe(on: MainScheduler.instance)
                        .subscribe(
                            onSuccess: { response in
                                AuthCache.live.saveTokens(
                                    Token: response.token,
                                    refreshToken: response.refreshToken,
                                    expires: response.tokenExpires
                                )
                                AuthInterceptor.isRefreshing = false
                                AuthInterceptor.retrySubject.onNext(())
                            },
                            onFailure: { error in
                                AuthInterceptor.isRefreshing = false
                                AuthManager.shared.logout()
                            }
                        )
                        .disposed(by: disposeBag)
                }
                
                AuthInterceptor.retrySubject
                    .take(1)
                    .subscribe(onNext: {
                        if let token = AuthCache.live.getToken(of: .Token) {
                            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                        }
                        completion(.success(request))
                    })
                    .disposed(by: disposeBag)
                return
            }
        }
        
        if let token = AuthCache.live.getToken(of: .Token) {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard request.retryCount < retryLimit else {
            print("[AuthInterceptor] 로그아웃")
            AuthManager.shared.logout()
            return completion(.doNotRetry)
        }

        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            if AuthInterceptor.isRefreshing {
                AuthInterceptor.retrySubject
                    .take(1)
                    .subscribe(onNext: { _ in
                        completion(.retry)
                    })
                    .disposed(by: disposeBag)
                return
            }
            
            AuthInterceptor.isRefreshing = true
            AuthApi().refreshToken()
                .observe(on: MainScheduler.instance)
                .subscribe(
                    onSuccess: { response in
                        let newToken = response.token
                        let newExpires = response.tokenExpires
                        
                        print("[AuthInterceptor] 재발급 성공")
                        print("[AuthInterceptor] newToken: \(newToken)")
                        print("[AuthInterceptor] newExpires: \(newExpires)")
                        
                        AuthCache.live.saveTokens(
                            Token: newToken,
                            refreshToken: response.refreshToken,
                            expires: newExpires
                        )
                        
                        AuthInterceptor.isRefreshing = false
                        AuthInterceptor.retrySubject.onNext(())
                        completion(.retry)
                    },
                    onFailure: { error in
                        AuthInterceptor.isRefreshing = false
                        AuthInterceptor.retrySubject.onNext(())
                        print("[AuthInterceptor] 재발급 실패: \(error.localizedDescription)")
                        AuthManager.shared.logout()
                        completion(.doNotRetry)
                    }
                )
                .disposed(by: disposeBag)
        } else {
            completion(.doNotRetry)
        }
    }
}
