//
//  AuthCache.swift
//  PLEP
//
//  Created by 이다경 on 7/7/25.
//

import Foundation

enum TokenKey: String {
    case Token
    case refreshToken
    case tokenExpires
}

final class AuthCache {
    static let live = AuthCache()
    private init() {}
    
    func saveTokens(Token: String, refreshToken: String, expires: Int) {
        print("[AuthCache] 토큰 저장")
        KeychainManager.shared.save(key: TokenKey.Token.rawValue, value: Token)
        KeychainManager.shared.save(key: TokenKey.refreshToken.rawValue, value: refreshToken)
        KeychainManager.shared.save(key: TokenKey.tokenExpires.rawValue, value: String(expires))
    }
    
    func getToken(of key: TokenKey) -> String? {
        KeychainManager.shared.load(key: key.rawValue)
    }
    
    func getTokenExpireTime() -> Int? {
        if let str = KeychainManager.shared.load(key: TokenKey.tokenExpires.rawValue) {
            return Int(str)
        }
        return nil
    }

    func clearTokens() {
        KeychainManager.shared.delete(key: TokenKey.Token.rawValue)
        KeychainManager.shared.delete(key: TokenKey.refreshToken.rawValue)
        KeychainManager.shared.delete(key: TokenKey.tokenExpires.rawValue)
        
        UserDefaults.standard.removeObject(forKey: "expires")
    }
}
