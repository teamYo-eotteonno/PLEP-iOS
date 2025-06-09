//
//  LocationPlacesListSheet.swift
//  PLEP
//
//  Created by 이다경 on 6/9/25.
//

import SwiftUI

struct LocationPlacesListSheet: View {
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
                        VStack(spacing: 13) {
                            ForEach(0..<7) { _ in
                                PlaceSheetCell(
                                    name: "방탄소년단",
                                    category: "아이돌",
                                    information: "세계적인 아티스트",
                                    address: "빅히트본사",
                                    feednum: 999,
                                    enabled: true
                                )
                                Divider()
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
    LocationPlacesListSheet()
}
