//
//  SharingSheetCellType.swift
//  PLEP
//
//  Created by 이다경 on 6/4/25.
//

import SwiftUI

enum SharingSheetCellType: CaseIterable {
    case target, kakao, discord, email
}

struct SharingSheetCellStyle {
    let type: SharingSheetCellType
    
    var img: String {
        switch type {
        case .target: return Asset.Share.target
        case .kakao: return Asset.Share.kakao
        case .discord: return Asset.Share.discord
        case .email: return Asset.Share.email
        }
    }
    
    var title: String {
        switch type {
        case .target: return "공유"
        case .kakao: return "카카오톡"
        case .discord: return "디스코드"
        case .email: return "이메일"
        }
    }
}
