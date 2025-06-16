//
//  DropdownTestView.swift
//  PLEP
//
//  Created by 이다경 on 5/9/25.
//

import SwiftUI

struct DropdownTestView: View {
    @State private var selection1 = ""
    @State private var selection2 = ""
    
    var body: some View {
        VStack {
            PLEPDropdown(
                title: "옵션 선택",
                options: [
                    .red: "빨강",
                    .green: "초록",
                    .yellow: "선택 안 함",
                    .blue: "파랑"
                ],
                selection: $selection1
            )
            PLEPDropdown(
                title: "E-mail",
                options: ["naver.com", "gmail.com", "kakao.com", "기타"],
                selection: $selection2
            )
        }
    }
}

#Preview {
    DropdownTestView()
}
