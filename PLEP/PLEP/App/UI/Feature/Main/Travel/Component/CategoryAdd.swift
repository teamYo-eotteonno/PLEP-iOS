//
//  CategoryAdd.swift
//  PLEP
//
//  Created by 이다경 on 6/9/25.
//

import SwiftUI

struct CategoryAdd: View {
    let null: Bool
    let onCategory: () -> Void
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: onCategory) {
                HStack(spacing: 3) {
                    Image(Asset.Circle.add)
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("카테고리 추가")
                        .textStyle.body.bold
                        .foregroundColor(.txt.primary)
                }
            }
            if !null {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 3) {
                        ForEach(0..<3) { _ in
                            PLEPTag(
                                title: "💜ARMY",
                                type: .outlined,
                                size: .small,
                                enabled: true
                            )
                        }
                    }
                }
            } else {
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .padding(.leading, 25)
        .background(Color.g[0])
    }
}
