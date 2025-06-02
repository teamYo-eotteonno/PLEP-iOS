//
//  PlacesList.swift
//  PLEP
//
//  Created by 이다경 on 6/3/25.
//

import SwiftUI

struct PlacesList: View {
    let null: Bool
    
    var body: some View {
        if null {
            VStack(spacing: 5) {
                Image(Asset.Address.bigadd)
                    .resizable()
                    .frame(width: 100, height: 100)
                Text("장소를 추가해서 함께 여행갈")
                Text("장소를 찾아주세요!")
            }
            .textStyle.body.default
            .foregroundColor(.txt.tertiary)
            .padding(.horizontal, 76)
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
                        feednum: 999,
                        me: true,
                        action: {}
                    )
                }
                Button(action: {}) {
                    HStack(spacing: 3) {
                        Image(Asset.Address.add)
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("장소추가")
                            .textStyle.button.bold
                            .foregroundColor(.icon.tertiary)
                    }
                    .padding(.vertical, 10)
                }
            }
            .padding(.all, 10)
            .background(Color.g[100])
            .cornerRadius(15)
        }
    }
}

#Preview {
    PlacesList(null: true)
}
