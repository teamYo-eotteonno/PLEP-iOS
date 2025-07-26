//
//  ProfileTypeStorage.swift
//  PLEP
//
//  Created by 이다경 on 7/26/25.
//

import Foundation

final class ProfileTypeStorage {
    static let shared = ProfileTypeStorage()
    private let userDefaults = UserDefaults.standard
    private let keyPrefix = "plep_profile_type_"

    private init() {}

    func saveProfileType(userId: String, type: ProfileCellType) {
        let key = keyPrefix + userId
        userDefaults.set(type.rawValue, forKey: key)
    }

    func loadProfileType(userId: String) -> ProfileCellType? {
        let key = keyPrefix + userId
        guard let raw = userDefaults.string(forKey: key),
              let type = ProfileCellType(rawValue: raw) else {
            return nil
        }
        return type
    }

    func clearProfileType(userId: String) {
        let key = keyPrefix + userId
        userDefaults.removeObject(forKey: key)
    }
    
    func loadOrAssignDefault(userId: String) -> ProfileCellType {
        if let type = loadProfileType(userId: userId) {
            return type
        } else {
            let assigned: ProfileCellType = Bool.random() ? .way : .loke
            saveProfileType(userId: userId, type: assigned)
            print("[ProfileTypeStorage] 기존 기록 없음 → 자동 할당: \(assigned)")
            return assigned
        }
    }
}
