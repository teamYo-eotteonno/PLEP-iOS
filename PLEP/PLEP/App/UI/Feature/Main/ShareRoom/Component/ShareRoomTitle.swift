//
//  ShareRoomTopbar.swift
//  PLEP
//
//  Created by 이다경 on 6/4/25.
//

import SwiftUI

struct ShareRoomTitle: View {
    let my: Bool
    let title: String
    
    var body: some View {
        VStack(spacing: 0) {
            PLEPTopbar(type: .default, action: {})
            
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text(title)
                        .textStyle.title.header3
                    Spacer()
                    if my {
                        Button(action: {}) {
                            Image(Asset.more)
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    }
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 3) {
                        ForEach(0..<6) { _ in
                            PLEPTag(
                                title: "💜ARMY",
                                type: .outlined,
                                size: .small,
                                enabled: true
                            )
                        }
                    }
                }
                if my {
                    HStack(spacing: 5) {
                        Button(action: {}) {
                            HStack(spacing: 3) {
                                Image(Asset.User.Add.default)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("친구 초대")
                                    .textStyle.body.bold
                                    .foregroundColor(.txt.tertiary)
                            }
                        }
                        .padding(.all, 5)
                        
                        Rectangle()
                            .frame(width: 1, height: 18)
                            .foregroundColor(.g[400])
                        
                        Button(action: {}) {
                            HStack(spacing: 3) {
                                Image(Asset.trash)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("방 삭제")
                                    .textStyle.body.bold
                                    .foregroundColor(.txt.tertiary)
                            }
                        }
                        .padding(.all, 5)
                    }
                }
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 40)
            .background(Color.g[0])
//            Spacer()
        }
        .ignoresSafeArea()
    }
}
