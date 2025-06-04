//
//  ElsePlacesList.swift
//  PLEP
//
//  Created by 이다경 on 6/3/25.
//

import SwiftUI

struct ElsePlacesList: View {
    let null: Bool
    
    var body: some View {
        if null {
            VStack(spacing: 5) {
                Image(Asset.User.Add.Circle.big)
                    .resizable()
                    .frame(width: 100, height: 100)
                Text("멤버들을 더 추가해 많은 플레이스를")
                Text("추가해보세요!")
            }
            .textStyle.body.default
            .foregroundColor(.txt.tertiary)
//            .padding(.horizontal, 76)
//            .frame(width: 330)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 56)
            .background(Color.g[100])
            .cornerRadius(15)
        } else {
            VStack(spacing: 5) {
                ForEach(0..<4) { _ in
                    PlaceListCell(
                        name: "방탄소년단",
                        category: "아이돌",
                        information: "세계적인 아티스트",
                        address: "빅히트본사",
                        feednum: 999
                    )
                }
            }
            .padding(.all, 10)
            .frame(maxWidth: .infinity)
            .background(Color.g[100])
            .cornerRadius(15)
        }
    }
}
