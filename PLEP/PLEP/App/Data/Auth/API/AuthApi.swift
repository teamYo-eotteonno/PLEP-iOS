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
    
    func passcodeemail(body: CodeRequest) -> Single<EmptyResponse> {
        let url = URL(string: PLEPURL.Email.passcode)!
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
    
    private let noInterceptorSession = Session()

    func refreshToken() -> Single<RefreshTokenResponse> {
        print("[AuthApi.refreshToken] 호출됨")
        
        guard let refreshToken = AuthCache.live.getToken(of: .refreshToken) else {
            return Single.error(AFError.explicitlyCancelled)
        }
        
        let url = URL(string: PLEPURL.Auth.refresh)!
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(refreshToken)"
        ]
        
        return Single.create { single in
            let request = self.noInterceptorSession.request(
                url,
                method: .post,
                headers: headers
            )
<<<<<<< HEAD
<<<<<<< HEAD
            .responseData { response in
                let statusCode = response.response?.statusCode ?? 0
                print("\n[AuthApi.refreshToken] statusCode: \(statusCode)")
                
                switch response.result {
                case .success(let data):
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("[🟥 AuthApi.refreshToken] 서버 원본 응답(json): \(jsonString)")
                    }
                    
                    let decoder = JSONDecoder()
                    
                    if let model = try? decoder.decode(RefreshTokenResponse.self, from: data) {
                        let oldToken = AuthCache.live.getToken(of: .Token) ?? "nil"
                        print("[refreshToken API] 기존 token: \(oldToken)")
                        print("[refreshToken API] 새 token: \(model.token)")
                        print("[refreshToken API] 새 refreshToken: \(model.refreshToken)")
                        
=======
            .validate(statusCode: 200..<300)
=======
>>>>>>> 3df87c0 (2025.07.20/토큰 관리 수정)
            .responseData { response in
                let statusCode = response.response?.statusCode ?? 0
                print("\n[AuthApi.refreshToken] statusCode: \(statusCode)")
                
                switch response.result {
                case .success(let data):
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("[🟥 AuthApi.refreshToken] 서버 원본 응답(json): \(jsonString)")
                    }
                    
<<<<<<< HEAD
                    if let model = try? JSONDecoder().decode(RefreshTokenResponse.self, from: data) {
>>>>>>> bf4e9bb (2025.07.19/진짜 최종 이젠 수정 안함 토큰 완료, 그룹 리스트 띄우기)
=======
                    let decoder = JSONDecoder()
                    
                    if let model = try? decoder.decode(RefreshTokenResponse.self, from: data) {
                        let oldToken = AuthCache.live.getToken(of: .Token) ?? "nil"
                        print("[refreshToken API] 기존 token: \(oldToken)")
                        print("[refreshToken API] 새 token: \(model.token)")
                        print("[refreshToken API] 새 refreshToken: \(model.refreshToken)")
                        
>>>>>>> 3df87c0 (2025.07.20/토큰 관리 수정)
                        AuthCache.live.saveTokens(
                            Token: model.token,
                            refreshToken: model.refreshToken,
                            expires: model.tokenExpires
                        )
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 3df87c0 (2025.07.20/토큰 관리 수정)
                        
                        let savedToken = AuthCache.live.getToken(of: .Token) ?? "nil"
                        let savedExpires = AuthCache.live.getTokenExpireTime()
                        print("[AuthInterceptor] saveTokens 후 getToken: \(savedToken)")
                        print("🟩 저장 후 expires: \(savedExpires ?? -1)")
                        
<<<<<<< HEAD
                        single(.success(model))
                        
                    } else if let decoded = try? decoder.decode(SecondErrorReason.self, from: data) {
                        let code = decoded.statusCode
                        let message = decoded.message
                        let error = NSError(domain: "AuthApi", code: code, userInfo: [NSLocalizedDescriptionKey: message])
                        
                        print("[AuthApi.refreshToken] decode SecondErrorReason: \(message), statusCode: \(code)")
                        single(.failure(error))
                        
                    } else {
                        print("[AuthApi.refreshToken] unknown decode error. data: \(String(data: data, encoding: .utf8) ?? "nil")")
                        let error = NSError(domain: "AuthApi", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "알 수 없는 오류가 발생했습니다."])
=======
=======
>>>>>>> 3df87c0 (2025.07.20/토큰 관리 수정)
                        single(.success(model))
                        
                    } else if let decoded = try? decoder.decode(SecondErrorReason.self, from: data) {
                        let code = decoded.statusCode
                        let message = decoded.message
                        let error = NSError(domain: "AuthApi", code: code, userInfo: [NSLocalizedDescriptionKey: message])
                        
                        print("[AuthApi.refreshToken] decode SecondErrorReason: \(message), statusCode: \(code)")
                        single(.failure(error))
<<<<<<< HEAD
                    }
                    else {
                        let error = NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "알 수 없는 오류가 발생했습니다."])
>>>>>>> bf4e9bb (2025.07.19/진짜 최종 이젠 수정 안함 토큰 완료, 그룹 리스트 띄우기)
=======
                        
                    } else {
                        print("[AuthApi.refreshToken] unknown decode error. data: \(String(data: data, encoding: .utf8) ?? "nil")")
                        let error = NSError(domain: "AuthApi", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "알 수 없는 오류가 발생했습니다."])
>>>>>>> 3df87c0 (2025.07.20/토큰 관리 수정)
                        single(.failure(error))
                    }
                    
                case .failure(let error):
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 3df87c0 (2025.07.20/토큰 관리 수정)
                    print("🔎 최종 헤더: \(headers)")
                    print("[AuthApi.refreshToken] failure statusCode: \(statusCode)")
                    
                    if let data = response.data,
                       let jsonString = String(data: data, encoding: .utf8) {
                        print("[🟥 AuthApi.refreshToken] failure json: \(jsonString)")
                    }
                    
                    if statusCode == 401 {
                        let authError = NSError(domain: "AuthApi", code: 401, userInfo: [NSLocalizedDescriptionKey: "RefreshToken이 만료되었습니다."])
                        single(.failure(authError))
                    } else {
                        single(.failure(error))
                    }
<<<<<<< HEAD
=======
                    print("[AuthApi.refreshToken] failure: \(error.localizedDescription)")
                    single(.failure(error))
>>>>>>> bf4e9bb (2025.07.19/진짜 최종 이젠 수정 안함 토큰 완료, 그룹 리스트 띄우기)
=======
>>>>>>> 3df87c0 (2025.07.20/토큰 관리 수정)
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
