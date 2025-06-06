//
//  NumberingList.swift
//  PLEP
//
//  Created by 이다경 on 6/3/25.
//

import SwiftUI

struct NumberingList: View {
    let num: Int
    
    var body: some View {
        VStack(spacing: 5) {
            ForEach(1..<num+1) { i in
                PlaceListCell(
                    name: "방탄소년단",
                    category: "아이돌",
                    information: "세계적인 아티스트",
                    address: "빅히트본사",
                    feednum: 999,
                    numbering: true,
                    number: i
                )
            }
        }
        .padding(.all, 10)
        .background(Color.g[100])
        .cornerRadius(15)
    }
}
