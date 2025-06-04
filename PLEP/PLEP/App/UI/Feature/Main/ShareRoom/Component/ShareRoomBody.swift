//
//  ShareRoomBody.swift
//  PLEP
//
//  Created by 이다경 on 6/4/25.
//

import SwiftUI

struct ShareRoomBody: View {
    let member: String
    var body: some View {
        ZStack {
            Color.g[0].ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 40) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("내가 선택한 장소")
                            .textStyle.title.subtitle
                            .foregroundColor(.txt.primary)
                        MyPlacesList(null: false)
                    }
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text(member+"님이 선택한 장소")
                            .textStyle.title.subtitle
                            .foregroundColor(.txt.primary)
                        ElsePlacesList(null: false)
                    }
                }
                .padding(.all, 25)
            }
        }
    }
}
