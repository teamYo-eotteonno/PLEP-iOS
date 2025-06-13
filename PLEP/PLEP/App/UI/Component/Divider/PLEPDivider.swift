//
//  PLEPDivider.swift
//  PLEP
//
//  Created by 이다경 on 6/13/25.
//

import SwiftUI

enum PLEPDividerType {
    case g50, g100, g200, g300
}

struct PLEPDivider: View {
    let type: PLEPDividerType
    
    var body: some View {
        Rectangle()
            .frame(height: 1)
            .frame(maxWidth: .infinity)
            .foregroundColor({
                switch type {
                case.g50: Color.g[50]
                case.g100: Color.g[100]
                case.g200: Color.g[200]
                case.g300: Color.g[300]
                }
            }())
    }
}

