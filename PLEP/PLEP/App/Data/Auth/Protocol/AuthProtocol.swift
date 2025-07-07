//
//  AuthProtocol.swift
//  PLEP
//
//  Created by 이다경 on 7/6/25.
//

import Foundation
import Combine
import Alamofire

protocol AuthProtocol {
    func join(body: JoinRequest) -> DataRequest
    func codeemail(body: CodeRequest) -> DataRequest
    func login(body: LoginRequest) -> AnyPublisher<DataResponse<LoginModel, AFError>, Never>
}
