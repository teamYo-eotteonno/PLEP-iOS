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
}

final class AuthCache {
    static let live = AuthCache()
    private init() {}
    
    func saveTokens(Token: String, refreshToken: String) {
        KeychainManager.shared.save(key: TokenKey.Token.rawValue, value: Token)
        KeychainManager.shared.save(key: TokenKey.refreshToken.rawValue, value: refreshToken)
    }
    
    func saveToken(_ token: String, to key: TokenKey) {
            KeychainManager.shared.save(key: key.rawValue, value: token)
        }

    func getToken(of key: TokenKey) -> String? {
        KeychainManager.shared.load(key: key.rawValue)
    }

    func clearTokens() {
        KeychainManager.shared.delete(key: TokenKey.Token.rawValue)
        KeychainManager.shared.delete(key: TokenKey.refreshToken.rawValue)
    }
}
