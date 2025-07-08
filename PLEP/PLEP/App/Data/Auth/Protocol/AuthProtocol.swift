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
    func join(body: JoinRequest) -> Single<EmptyResponse>
    func codeemail(body: CodeRequest) -> Single<EmptyResponse>
    func login(body: LoginRequest) -> Single<LoginModel>
    func refreshToken() -> Single<RefreshTokenResponse>
}
