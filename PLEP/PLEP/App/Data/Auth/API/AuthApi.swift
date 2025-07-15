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
    
    func join(body: JoinRequest) -> Single<EmptyResponse> {
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
                switch response.result {
                case .success(let model):
                    single(.success(model))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            
            return Disposables.create { request.cancel() }
        }
    }
    
    func codeemail(body: CodeRequest) -> Single<EmptyResponse> {
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
            .response { response in
                switch response.result {
                case .success:
                    single(.success(EmptyResponse()))
                case .failure(let error):
                    single(.failure(error))
                }
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
            .validate(statusCode: 200..<500)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    if let model = try? JSONDecoder().decode(LoginModel.self, from: data) {
                        AuthCache.live.saveTokens(
                            Token: model.token,
                            refreshToken: model.refreshToken,
                            expires: model.tokenExpires
                        )
                        single(.success(model))
                    }
                    else if let decoded = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        let messages = decoded.errors.map { $0.value }.joined(separator: "\n")
                        let error = NSError(domain: "", code: decoded.status, userInfo: [NSLocalizedDescriptionKey: messages])
                        single(.failure(error))
                    }
                    else {
                        let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "알 수 없는 오류가 발생했습니다."])
                        single(.failure(error))
                    }
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create { request.cancel() }
        }
    }
    
    func refreshToken() -> Single<RefreshTokenResponse> {
        guard let refreshToken = AuthCache.live.getToken(of: .refreshToken) else {
            return Single.error(AFError.explicitlyCancelled)
        }
        
        let url = URL(string: PLEPURL.Auth.refresh)!
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        let body = RefreshTokenRequest(token: refreshToken)
        
        return Single.create { single in
            let request = API.session.request(
                url,
                method: .post,
                parameters: body,
                encoder: JSONParameterEncoder.default,
                headers: headers
            )
            .validate()
            .responseDecodable(of: RefreshTokenResponse.self) { response in
                switch response.result {
                case .success(let model):
                    AuthCache.live.saveTokens(
                        Token: model.token,
                        refreshToken: model.refreshToken,
                        expires: model.tokenExpires
                    )
                    single(.success(model))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            
            return Disposables.create { request.cancel() }
        }
        .observe(on: MainScheduler.instance)
    }
    
    func getMe() -> Single<UserModel> {
        return Single.create { single in
            let request = API.session.request(
                PLEPURL.Auth.getMe,
                method: .get
            )
            .validate()
            .responseDecodable(of: UserModel.self) { response in
                switch response.result {
                case .success(let user):
                    single(.success(user))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            
            return Disposables.create { request.cancel() }
        }
        .observe(on: MainScheduler.instance)
    }
}
