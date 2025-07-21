//
//  KeychainManager.swift
//  PLEP
//
//  Created by 이다경 on 7/7/25.
//

import Foundation
import Security

final class KeychainManager {
    static let shared = KeychainManager()
    private init() {}
    
    func save(key: String, value: String) {
        guard let data = value.data(using: .utf8) else { return }
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data
        ]
        SecItemDelete(query as CFDictionary)
<<<<<<< HEAD
<<<<<<< HEAD
        SecItemAdd(query as CFDictionary, nil)
=======
        let status = SecItemAdd(query as CFDictionary, nil)
        print("[KeychainManager] save status: \(status)")
>>>>>>> bf4e9bb (2025.07.19/진짜 최종 이젠 수정 안함 토큰 완료, 그룹 리스트 띄우기)
=======
        SecItemAdd(query as CFDictionary, nil)
>>>>>>> 3df87c0 (2025.07.20/토큰 관리 수정)
    }

    func load(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status == errSecSuccess,
              let data = result as? Data,
              let string = String(data: data, encoding: .utf8) else {
            return nil
        }
        return string
    }

    func delete(key: String) {
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key
        ]
        SecItemDelete(query as CFDictionary)
    }
}
