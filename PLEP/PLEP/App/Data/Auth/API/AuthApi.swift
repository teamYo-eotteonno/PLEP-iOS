//
//  AuthApi.swift
//  PLEP
//
//  Created by 이다경 on 7/6/25.
//

import Foundation
import Alamofire
import RxSwift

struct AuthApi: AuthProtocol {
    
    func join(body: JoinRequest) -> Single<DataResponse<EmptyResponse, AFError>> {
        let url = URL(string: PLEPURL.Auth.join)!
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        return Single.create { single in
            let request = AF.request(
                url,
                method: .post,
                parameters: body,
                encoder: JSONParameterEncoder.default,
                headers: headers
            )
            .validate()
            .responseDecodable(of: EmptyResponse.self) { response in
                single(.success(response))
            }
            
            return Disposables.create { request.cancel() }
        }
    }
    
    func codeemail(body: CodeRequest) -> Single<DataResponse<EmptyResponse, AFError>> {
        let url = URL(string: PLEPURL.Email.code)!
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        return Single.create { single in
            let request = AF.request(
                url,
                method: .post,
                parameters: body,
                encoder: JSONParameterEncoder.default,
                headers: headers
            )
            .validate()
            .responseDecodable(of: EmptyResponse.self) { response in
                single(.success(response))
            }
            
            return Disposables.create { request.cancel() }
        }
    }
    
    func login(body: LoginRequest) -> Single<LoginModel> {
        let url = URL(string: PLEPURL.Auth.login)!
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        return Single.create { single in
            let request = AF.request(
                url,
                method: .post,
                parameters: body,
                encoder: JSONParameterEncoder.default,
                headers: headers
            )
            .validate()
            .responseDecodable(of: LoginModel.self) { response in
                switch response.result {
                case .success(let model):
                    single(.success(model))
                case .failure(let error):
                    if let data = response.data,
                       let decoded = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        let messages = decoded.errors.map { "\($0.key): \($0.value)" }.joined(separator: "\n")
                        single(.failure(NSError(domain: "", code: decoded.status, userInfo: [NSLocalizedDescriptionKey: messages])))
                    } else {
                        single(.failure(error))
                    }
                }
            }
            
            return Disposables.create { request.cancel() }
        }
    }
    
    func refreshToken() -> Single<DataResponse<RefreshTokenResponse, AFError>> {
        guard let refreshToken = AuthCache.live.getToken(of: .refreshToken) else {
            return Single.just(
                DataResponse<RefreshTokenResponse, AFError>(
                    request: nil,
                    response: nil,
                    data: nil,
                    metrics: nil,
                    serializationDuration: 0,
                    result: .failure(AFError.explicitlyCancelled))
            )
        }
        
        let url = URL(string: PLEPURL.Auth.refresh)!
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        let body = RefreshTokenRequest(token: refreshToken)
        
        return Single.create { single in
            let request = AF.request(
                url,
                method: .post,
                parameters: body,
                encoder: JSONParameterEncoder.default,
                headers: headers
            )
            .validate()
            .responseDecodable(of: RefreshTokenResponse.self) { response in
                if let newToken = response.value?.token,
                   let refreshToken = response.value?.refreshToken {
                    AuthCache.live.saveTokens(
                        Token: newToken,
                        refreshToken: refreshToken
                    )
                }
                single(.success(response))
            }
            
            return Disposables.create { request.cancel() }
        }
        .observe(on: MainScheduler.instance)
    }
}
