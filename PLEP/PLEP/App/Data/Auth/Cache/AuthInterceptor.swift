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
    private let retryLimit = 1
    private let disposeBag = DisposeBag()
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
<<<<<<< HEAD
<<<<<<< HEAD
        
        if let token = AuthCache.live.getToken(of: .Token), !token.isEmpty {
=======
        print("[AuthInterceptor][adapt] 호출됨")

        let now = Int(Date().timeIntervalSince1970)
        if let expiresMs = AuthCache.live.getTokenExpireTime() {
            let expires = expiresMs / 1000
            print("[AuthInterceptor][adapt] expires: \(expires), now: \(now)")

            if expires < now {
                print("[AuthInterceptor][adapt] 토큰 만료됨. refresh 시도")
                if !AuthInterceptor.isRefreshing {
                    AuthInterceptor.isRefreshing = true
                    print("[AuthInterceptor][adapt] isRefreshing false → true")
                    
                    AuthApi().refreshToken()
                        .observe(on: MainScheduler.instance)
                        .subscribe(
                            onSuccess: { response in
                                print("[AuthInterceptor][adapt] refresh 성공. 새 토큰 저장")
                                AuthCache.live.saveTokens(
                                    Token: response.token,
                                    refreshToken: response.refreshToken,
                                    expires: response.tokenExpires
                                )
                                AuthInterceptor.isRefreshing = false
                                AuthInterceptor.retrySubject.onNext(())
                            },
                            onFailure: { error in
                                print("[AuthInterceptor][adapt] refresh 실패: \(error.localizedDescription)")
                                AuthInterceptor.isRefreshing = false
                                AuthManager.shared.logout()
                            }
                        )
                        .disposed(by: disposeBag)
                } else {
                    print("[AuthInterceptor][adapt] 이미 isRefreshing 중")
                }
                
                AuthInterceptor.retrySubject
                    .take(1)
                    .subscribe(onNext: {
                        print("[AuthInterceptor][adapt] retrySubject onNext 수신. 재시도 진행")
                        if let token = AuthCache.live.getToken(of: .Token) {
                            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                        }
                        completion(.success(request))
                    })
                    .disposed(by: disposeBag)
                return
            }
        } else {
            print("[AuthInterceptor][adapt] expiresMs nil")
        }

        if let token = AuthCache.live.getToken(of: .Token) {
            print("[AuthInterceptor][adapt] 기존 토큰 사용")
>>>>>>> bf4e9bb (2025.07.19/진짜 최종 이젠 수정 안함 토큰 완료, 그룹 리스트 띄우기)
=======
        
        if let token = AuthCache.live.getToken(of: .Token), !token.isEmpty {
>>>>>>> 3df87c0 (2025.07.20/토큰 관리 수정)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        completion(.success(request))
    }
<<<<<<< HEAD

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
<<<<<<< HEAD
        print("[AuthInterceptor] retry called, retryCount: \(request.retryCount)")
            
            if let afError = error as? AFError, afError.isExplicitlyCancelledError {
                print("[AuthInterceptor] 요청이 explicitlyCancelled 되었으므로 retry 하지 않음")
                return completion(.doNotRetry)
            }

            guard let response = request.task?.response as? HTTPURLResponse else {
                print("[AuthInterceptor] response 없음, retry 안 함")
                return completion(.doNotRetry)
            }
        
        print("[AuthInterceptor] response status code: \(response.statusCode)")
        
        guard request.retryCount < retryLimit else {
            print("[AuthInterceptor] retryLimit 초과, 로그아웃 처리")
            AuthManager.shared.logout()
            return completion(.doNotRetry)
        }
        
        if response.statusCode == 401 {
            print("[AuthInterceptor] 401 에러 감지, refreshToken 호출 시도")
            
=======
        print("[AuthInterceptor][retry] 호출됨. retryCount: \(request.retryCount)")
=======
>>>>>>> 3df87c0 (2025.07.20/토큰 관리 수정)

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("[AuthInterceptor] retry called, retryCount: \(request.retryCount)")
            
            if let afError = error as? AFError, afError.isExplicitlyCancelledError {
                print("[AuthInterceptor] 요청이 explicitlyCancelled 되었으므로 retry 하지 않음")
                return completion(.doNotRetry)
            }

            guard let response = request.task?.response as? HTTPURLResponse else {
                print("[AuthInterceptor] response 없음, retry 안 함")
                return completion(.doNotRetry)
            }
        
        print("[AuthInterceptor] response status code: \(response.statusCode)")
        
        guard request.retryCount < retryLimit else {
            print("[AuthInterceptor] retryLimit 초과, 로그아웃 처리")
            AuthManager.shared.logout()
            return completion(.doNotRetry)
        }
        
        if response.statusCode == 401 {
            print("[AuthInterceptor] 401 에러 감지, refreshToken 호출 시도")
            
<<<<<<< HEAD
            if AuthInterceptor.isRefreshing {
                print("[AuthInterceptor][retry] 이미 isRefreshing 중. retrySubject 대기")
                AuthInterceptor.retrySubject
                    .take(1)
                    .subscribe(onNext: { _ in
                        print("[AuthInterceptor][retry] retrySubject onNext 수신. 재시도")
                        completion(.retry)
                    })
                    .disposed(by: disposeBag)
                return
            }
            
            AuthInterceptor.isRefreshing = true
            print("[AuthInterceptor][retry] isRefreshing false → true. refresh 시도")

>>>>>>> bf4e9bb (2025.07.19/진짜 최종 이젠 수정 안함 토큰 완료, 그룹 리스트 띄우기)
=======
>>>>>>> 3df87c0 (2025.07.20/토큰 관리 수정)
            AuthApi().refreshToken()
                .subscribe(
                    onSuccess: { model in
                        print("[AuthInterceptor] refreshToken 성공")
                        AuthCache.live.saveTokens(
                            Token: model.token,
                            refreshToken: model.refreshToken,
                            expires: model.tokenExpires
                        )
                        completion(.retry)
                    },
                    onFailure: { error in
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 3df87c0 (2025.07.20/토큰 관리 수정)
                        print("[AuthInterceptor] refreshToken 실패: \(error)")

                        if let nsError = error as NSError?, nsError.code == 401 {
                            print("[AuthInterceptor] refreshToken 401 실패, 로그아웃")
                            AuthManager.shared.logout()
                            completion(.doNotRetry)
                        } else {
                            completion(.doNotRetry)
                        }
<<<<<<< HEAD
=======
                        print("[AuthInterceptor] 재발급 실패: \(error.localizedDescription)")
                        AuthInterceptor.isRefreshing = false
                        AuthInterceptor.retrySubject.onNext(())
                        AuthManager.shared.logout()
                        completion(.doNotRetry)
>>>>>>> bf4e9bb (2025.07.19/진짜 최종 이젠 수정 안함 토큰 완료, 그룹 리스트 띄우기)
=======
>>>>>>> 3df87c0 (2025.07.20/토큰 관리 수정)
                    }
                )
                .disposed(by: disposeBag)
        } else {
<<<<<<< HEAD
<<<<<<< HEAD
            print("[AuthInterceptor] 401 아님, retry 안 함")
=======
            print("[AuthInterceptor][retry] 401 아님. doNotRetry")
>>>>>>> bf4e9bb (2025.07.19/진짜 최종 이젠 수정 안함 토큰 완료, 그룹 리스트 띄우기)
=======
            print("[AuthInterceptor] 401 아님, retry 안 함")
>>>>>>> 3df87c0 (2025.07.20/토큰 관리 수정)
            completion(.doNotRetry)
        }
    }
}
