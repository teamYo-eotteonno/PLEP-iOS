//
//  PlacesListSheet.swift
//  PLEP
//
//  Created by 이다경 on 5/30/25.
//

import SwiftUI
import FlowKit

struct PlacesListSheet: View {
    @Flow var flow
    @State private var search = ""
    
    var body: some View {
        ZStack {
            Color.g[50].ignoresSafeArea()
        ScrollView {
                VStack(spacing: 20) {
                    VStack(alignment: .trailing) {
                        PLEPTextField(
                            text: $search,
                            placeholder: "장소를 재검색 해주세요.",
                            isSecure: false,
                            validate: { !$0.isEmpty },
                            errorMessage: "닉네임을 입력해주세요",
                            icon_t: true
                        )
                        HStack(spacing: 3) {
                            Image(Asset.gps)
                                .resizable()
                                .frame(width: 15, height: 15)
                            Text("현재 내 위치로 찾기")
                                .textStyle.title.pre
                                .foregroundColor(.txt.quartemary)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        if search.isEmpty {
                            Text("주변에 있는 장소들")
                                .textStyle.title.header3
                                .foregroundColor(.txt.primary)
                            
                            HStack {
                                Text("현재 위치를 기준으로 반경 ")
                                    .foregroundColor(.txt.primary)
                                + Text("1km")
                                    .foregroundColor(.p[500])
                                + Text("에 있는 장소들")
                                    .foregroundColor(.txt.primary)
                            }
                            .textStyle.body.default
                            
                            ForEach(0..<7) { _ in
                                Button {
                                    flow.push(PlaceInformationSheet(title: "방탄소년단", name: "전정국", category: "아이돌", feednum: 999, address: "빅히트본사", phonenum: "010-1234-1234", url: "bighit.com", feed: true))
                                } label: {
                                    SearchingCell(
                                        name: "방탄소년단",
                                        category: "아이돌",
                                        information: "세계적인 아티스트",
                                        address: "빅히트본사",
                                        feednum: 999
                                    )
                                }
                            }
                        } else {
                            VStack(spacing: 13) {
                                ForEach(0..<7) { _ in
                                    PlaceSheetCell(
                                        name: "방탄소년단",
                                        category: "아이돌",
                                        information: "세계적인 아티스트",
                                        address: "빅히트본사",
                                        feednum: 999,
                                        enabled: false
                                    )
                                    Divider()
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 25)
//                .padding(.bottom, 250)
            }
        }
    }
}

#Preview {
    PlacesListSheet()
}
