//
//  ShaerRoomView.swift
//  PLEP
//
//  Created by 이다경 on 6/3/25.
//

import SwiftUI

struct ShareRoomView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ShareRoomTitle(my: true, title: "아포방포")
                ShareRoomBody(member: "민슈가")
            }
            .background(Color.g[100])
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ShareRoomView()
}
