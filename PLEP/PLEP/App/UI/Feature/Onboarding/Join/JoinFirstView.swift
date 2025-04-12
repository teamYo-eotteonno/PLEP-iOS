//
//  JoinFirstView.swift
//  PLEP
//
//  Created by 이다경 on 4/12/25.
//

import SwiftUI

struct JoinFirstView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        
        PLEPTextField(
            text: $email,
            placeholder: "이메일",
            color: .gray,
            login: false,
            validate: { $0.contains("@") },
            errorMessage: "올바른 이메일 주소를 입력해주세요."
        )
        
        PLEPTextField(
            text: $password,
            placeholder: "비밀번호",
            color: .dark,
            login: false,
            isSecure: true,
            validate: { $0.count >= 6 },
            errorMessage: "올바른 이메일 주소를 입력해주세요."
        )
    }
}


#Preview {
    JoinFirstView()
}
