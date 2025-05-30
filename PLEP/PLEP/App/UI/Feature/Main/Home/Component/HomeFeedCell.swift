//
//  HomeFeedCell.swift
//  PLEP
//
//  Created by 이다경 on 5/29/25.
//

import SwiftUI

struct HomeFeedCell: View {
    let name: String
    let fllows: Int
    @State private var isLiked = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                HStack(spacing: 10) {
                    Circle()
                        .foregroundColor(.clear)
                        .frame(width: 45)
                        .background(
                            Image("Dummy1")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 45, height: 45)
                                .clipShape(Circle())
                        )
                    VStack(alignment: .leading) {
                        Text(name+"님")
                            .textStyle.body.bold
                            .foregroundColor(.txt.secondary)
                        Text(String(fllows)+"Fllows")
                            .textStyle.body.small
                            .foregroundColor(.txt.tertiary)
                    }
                }
                Spacer()
                Button(action: { isLiked.toggle() }) {
                    Image(isLiked ? Asset.Heart.tap : Asset.Heart.default)
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            }
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 167)
                .background(
                    Image("Dummy2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 167)
                        .clipped()
                )
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(0..<7) { _ in
                        PLEPTag(
                            title: "핫플",
                            type: .neutral,
                            size: .small,
                            enabled: true
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    HomeFeedCell(name: "JK", fllows: 90000)
}
