//
//  AuthManager.swift
//  PLEP
//
//  Created by 이다경 on 7/8/25.
//

import RxSwift
import Foundation

final class AuthManager: ObservableObject {
    static let shared = AuthManager()
    
    private let disposeBag = DisposeBag()
    
    @Published var isLoggedIn: Bool = {
        let token = AuthCache.live.getToken(of: .Token)
        return token != nil && !token!.isEmpty
    }()
    
    private init() {
        checkLoginStatus()
    }
    
    func logout() {
        print("[AuthManager] logout 호출됨")
        AuthCache.live.clearTokens()
        isLoggedIn = false
        
        NotificationCenter.default.post(name: .didLogout, object: nil)
        
        API.session.session.invalidateAndCancel()
        API.recreateSession()
    }

    func loginSucceeded() {
        isLoggedIn = true
    }
    
    func checkLoginStatus() {
        let token = AuthCache.live.getToken(of: .Token) ?? ""
        let refresh = AuthCache.live.getToken(of: .refreshToken) ?? ""

        print("[AuthManager] checkLoginStatus - token: \(token), refresh: \(refresh)")

        if !token.isEmpty && !isTokenExpired(token) {
            isLoggedIn = true
            return
        }

        if !refresh.isEmpty && !isTokenExpired(refresh) {
            print("[AuthManager] accessToken 만료, refreshToken 유효 → refreshToken API 호출")
            
            AuthApi().refreshToken()
                .subscribe(
                    onSuccess: { model in
                        print("[AuthManager] refreshToken 성공 → 새 토큰 저장 후 로그인 true")
                        AuthCache.live.saveTokens(
                            Token: model.token,
                            refreshToken: model.refreshToken,
                            expires: model.tokenExpires
                        )
                        self.isLoggedIn = true
                    },
                    onFailure: { error in
                        print("[AuthManager] refreshToken 실패 → 로그아웃")
                        self.isLoggedIn = false
                        self.logout()
                    }
                )
                .disposed(by: disposeBag)
            
            return
        }

        isLoggedIn = false
        logout()
    }
}

func isTokenExpired(_ token: String) -> Bool {
    let segments = token.split(separator: ".")
    guard segments.count == 3 else { return true }

    let payloadSegment = segments[1]
    var payload = payloadSegment.replacingOccurrences(of: "-", with: "+")
    payload = payload.replacingOccurrences(of: "_", with: "/")
    switch payload.count % 4 {
    case 2: payload += "=="
    case 3: payload += "="
    default: break
    }

    guard let data = Data(base64Encoded: payload),
          let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
          let exp = json["exp"] as? TimeInterval else { return true }

    let now = Date().timeIntervalSince1970
    return exp < now
}

extension Notification.Name {
    static let didLogout = Notification.Name("didLogout")
}
