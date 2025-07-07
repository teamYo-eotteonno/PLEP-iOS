//
//  AuthProtocol.swift
//  PLEP
//
//  Created by 이다경 on 7/6/25.
//

import Foundation
import RxSwift
import Alamofire

protocol AuthProtocol {
    func join(body: JoinRequest) -> Single<DataResponse<EmptyResponse, AFError>>
    func codeemail(body: CodeRequest) -> Single<DataResponse<EmptyResponse, AFError>>
    func login(body: LoginRequest) -> Single<DataResponse<LoginModel, AFError>>
    func refreshToken() -> Single<DataResponse<RefreshTokenResponse, AFError>>
}
