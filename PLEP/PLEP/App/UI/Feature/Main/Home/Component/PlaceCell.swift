//
//  PlaceCell.swift
//  PLEP
//
//  Created by 이다경 on 5/29/25.
//

import SwiftUI

struct PlaceCell: View {
    let name: String
    let category: String
    var information: String?
    let address: String
    let feednum: Int
    let enabled: Bool
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack(spacing: 11) {
                    Text(name)
                        .textStyle.body.bold
                        .foregroundColor(.txt.primary)
                    Rectangle()
                        .frame(width: 1, height: 16)
                        .foregroundColor(.txt.quartemary)
                    Text(category)
                        .textStyle.title.pre
                        .foregroundColor(.txt.tertiary)
                }
                Text(information ?? "(정보가 없는 장소 입니다.)")
                    .textStyle.body.bold
                    .foregroundColor((information != nil) ? .txt.primary : .txt.secondary)
                Text(address)
                    .textStyle.body.small
                    .foregroundColor(.txt.tertiary)
                HStack(spacing: 3) {
                    Text("피드 갯수 /")
                        .textStyle.title.pre
                        .foregroundColor(.txt.tertiary)
                    Text(String(feednum))
                        .textStyle.title.pre
                        .foregroundColor(.p[500])
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            if enabled {
                PLEPButton(
                    title: "위치 선택",
                    type: .neutral,
                    size: .small,
                    enabled: true,
                    icon: false,
                    action: {}
                )
                .padding(.top, 20)
            }
        }
        .padding(.horizontal, 10)
//        .padding(.horizontal, 51)
//        .frame(width: 311)
    }
}

#Preview {
    PlaceCell(
        name: "온오븐",
        category: "카페,디저트",
//        information: "맛있는 케이크와 디저트의 낙타",
        address: "대구광역시 달성군 화원읍 천내리 54-1 104호",
        feednum: 103,
        enabled: false
    )
}
