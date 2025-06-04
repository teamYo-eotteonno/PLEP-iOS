//
//  PlaceCell.swift
//  PLEP
//
//  Created by 이다경 on 6/2/25.
//

import SwiftUI

struct PlaceListCell: View {
    let name: String
    let category: String
    var information: String?
    let address: String
    let feednum: Int
    var me: Bool?
    var action: (() -> Void)?
    var numbering: Bool?
    var number: Int?
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                if numbering ?? false {
                    HStack(spacing: 15) {
                        Text(String(number ?? 0))
                            .textStyle.title.subtitle
                            .foregroundColor(.g[600])
                        Rectangle()
                            .foregroundColor(.g[200])
                            .frame(width: 1, height: 95.43)
                    }
                    .padding(.horizontal, 5)
                    .padding(.trailing, 5)
                }
                
                VStack(alignment: .leading) {
                    HStack(spacing: 11) {
                        Text(name)
                            .textStyle.body.bold
                            .foregroundColor(.txt.primary)
                        Rectangle()
                            .frame(width: 1, height: 16)
                            .foregroundColor(.txt.quartemary)
                        Text(category)
                            .textStyle.body.small
                            .foregroundColor(.txt.tertiary)
                        if me ?? false {
                            Spacer()
                            Button(action: { action }) {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .frame(width: 12, height: 12)
                                    .foregroundColor(.icon.quartemary)
                            }
                        }
                    }
                    Text(information ?? "(정보가 없는 장소 입니다.)")
                        .textStyle.body.default
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
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .background(Color.g[0])
            .cornerRadius(10)
        }
    }
}
