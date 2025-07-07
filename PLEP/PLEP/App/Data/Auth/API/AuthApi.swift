//
//  AuthApi.swift
//  PLEP
//
//  Created by 이다경 on 7/6/25.
//

import Foundation
import Alamofire
import Combine

struct AuthApi: AuthProtocol {
    
    func join(body: JoinRequest) -> DataRequest {
        let url = URL(string: PLEPURL.Auth.join)!
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        return AF.request(
            url,
            method: .post,
            parameters: body,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .validate()
    }
    
    func codeemail(body: CodeRequest) -> DataRequest {
        let url = URL(string: PLEPURL.Email.code)!
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        return AF.request(
            url,
            method: .post,
            parameters: body,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .validate()
    }
    
    func login(body: LoginRequest) -> AnyPublisher<DataResponse<LoginModel, AFError>, Never> {
        let url = URL(string: PLEPURL.Auth.login)!
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        return AF.request(
            url,
            method: .post,
            parameters: body,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .validate()
        .publishDecodable(type: LoginModel.self)
        .handleEvents(receiveOutput: { response in
            guard let tokens = response.value else { return }
            AuthCache.live.saveTokens(Token: tokens.token, refreshToken: tokens.refreshToken)
        })
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    typealias RefreshResponse = RefreshTokenResponse
    
    func refreshToken() -> AnyPublisher<DataResponse<RefreshResponse, AFError>, Never> {
        guard let refreshToken = AuthCache.live.getToken(of: .refreshToken) else {
            return Just(
                DataResponse<RefreshResponse, AFError>(
                    request: nil,
                    response: nil,
                    data: nil,
                    metrics: nil,
                    serializationDuration: 0,
                    result: .failure(AFError.explicitlyCancelled))
            )
            .eraseToAnyPublisher()
        }
        
        let url = URL(string: PLEPURL.Auth.refresh)!
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        let body = RefreshTokenRequest(token: refreshToken)
        
        return AF.request(
            url,
            method: .post,
            parameters: body,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .validate()
        .publishDecodable(type: RefreshResponse.self)
        .handleEvents(receiveOutput: { response in
            if let newToken = response.value?.token,
               let refreshToken = response.value?.refreshToken {
                AuthCache.live.saveTokens(
                    Token: newToken,
                    refreshToken: refreshToken
                )
            }
        })
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
