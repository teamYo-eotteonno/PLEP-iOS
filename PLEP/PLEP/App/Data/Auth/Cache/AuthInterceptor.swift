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
    private let retryLimit = 3
    private let disposeBag = DisposeBag()

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        
        if let token = AuthCache.live.getToken(of: .Token) {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            print("[AuthInterceptor] adapt() - Authorization header 추가됨")
        } else {
            print("[AuthInterceptor] adapt() - 토큰 없음")
        }
        
        completion(.success(request))
    }

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
            
            AuthApi.shared.refreshToken()
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
                        print("[AuthInterceptor] refreshToken 실패: \(error)")
                        
                        if let nsError = error as NSError?, nsError.code == 401 {
                            print("[AuthInterceptor] refreshToken 401 실패, 로그아웃")
                            AuthManager.shared.logout()
                            completion(.doNotRetry)
                        } else {
                            completion(.doNotRetry)
                        }
                    }
                )
                .disposed(by: disposeBag)
        } else {
            print("[AuthInterceptor] 401 아님, retry 안 함")
            completion(.doNotRetry)
        }
    }
}
