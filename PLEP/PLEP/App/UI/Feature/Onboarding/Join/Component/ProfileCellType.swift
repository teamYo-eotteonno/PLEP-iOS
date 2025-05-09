//
//  ProfileCellType.swift
//  PLEP
//
//  Created by 이다경 on 5/9/25.
//

import SwiftUI

enum ProfileCellType {
    case way, loke
}

struct ProfileCellStyle {
    let type: ProfileCellType
    
    var bgcColor: Color {
        switch type {
        case .way: return .p[200]
        case .loke: return .p[600]
        }
    }
    
    var imageName: String {
        switch type {
        case .way: return Asset.Character.way
        case .loke: return Asset.Character.loke
        }
    }
}
