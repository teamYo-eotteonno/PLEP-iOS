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
        if let token = AuthCache.live.getToken(of: .Token) {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard request.retryCount < retryLimit else {
            AuthManager.shared.logout()
            return completion(.doNotRetry)
        }

        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            AuthApi().refreshToken()
                .subscribe(
                    onSuccess: { response in
                        let newToken = response.token
                        AuthCache.live.saveToken(newToken, to: .Token)
                        completion(.retry)
                    },
                    onFailure: { error in
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
