//
//  DropdownTestView.swift
//  PLEP
//
//  Created by 이다경 on 5/9/25.
//

import SwiftUI

struct DropdownTestView: View {
    @State private var selected = ""
    
    var body: some View {
        PLEPDropdown(
            title: "E-mail",
            options: ["naver.com", "gmail.com", "kakao.com", "기타"],
            selection: $selected,
            type: .dark
        )
        
        PLEPDropdown(
            title: "E-mail",
            options: ["naver.com", "gmail.com", "kakao.com", "기타"],
            selection: $selected,
            type: .light
        )
    }
}

#Preview {
    DropdownTestView()
}
