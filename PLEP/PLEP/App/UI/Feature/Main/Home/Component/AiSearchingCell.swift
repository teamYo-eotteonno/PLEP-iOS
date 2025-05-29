//
//  AISearchingCell.swift
//  PLEP
//
//  Created by 이다경 on 5/29/25.
//

import SwiftUI

struct AiSearchingCell: View {
    let name: String
    let category: String
    var information: String?
    let address: String
    let feednum: Int
    
    var body: some View {
        VStack(spacing: 9) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 114)
                .background(
                    Image("Dummy3")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 114)
                        .clipped()
                )
                .cornerRadius(10)
            PlaceCell(
                name: name,
                category: category,
                information: information,
                address: address,
                feednum: feednum,
                enabled: false
            )
        }
        .padding(.horizontal, 51)
//        .padding(.horizontal, 10)
//        .frame(width: 311)
    }
}

#Preview {
    AiSearchingCell(
        name: "방탄소년단",
        category: "아이돌",
        information: "세계적인 아티스트",
        address: "빅히트본사",
        feednum: 999
    )
}
