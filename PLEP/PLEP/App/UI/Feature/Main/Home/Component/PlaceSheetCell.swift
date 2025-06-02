//
//  PlaceCell.swift
//  PLEP
//
//  Created by 이다경 on 5/29/25.
//

import SwiftUI

struct PlaceSheetCell: View {
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
                    action: {}
                )
                .padding(.top, 20)
            }
        }
        .padding(.horizontal, 10)
    }
}
