//
//  maskEmail.swift
//  PLEP
//
//  Created by 이다경 on 6/7/25.
//

import SwiftUI

func maskEmail(_ email: String) -> String {
    guard let atIndex = email.firstIndex(of: "@") else { return email }

    let username = email[..<atIndex]
    let domain = email[email.index(after: atIndex)...]

    let visiblePrefix = username.prefix(2)
    let maskedUsername = visiblePrefix + String(repeating: "*", count: max(0, username.count - 2))

    let domainParts = domain.split(separator: ".")
    let maskedDomain = String(repeating: "*", count: 5)
    let tld = domainParts.last ?? ""

    return "\(maskedUsername)@\(maskedDomain).\(tld)"
}
