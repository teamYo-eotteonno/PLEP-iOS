//
//  PlaceInformationSheet.swift
//  PLEP
//
//  Created by 이다경 on 5/29/25.
//

import SwiftUI

struct PlaceInformationSheet: View {
    @Environment(\.dismiss) private var dismiss
    let title: String
    
    let name: String
    let category: String
    var information: String?
    let feednum: Int
    let address: String
    let phonenum: String
    let url: String
    
    let feed: Bool
    
    var body: some View {
        ZStack {
            Color.g[50].ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    VStack(alignment: .leading, spacing: 15) {
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
                        VStack(alignment: .leading) {
                            Text(information ?? "(정보가 없는 장소 입니다.)")
                                .textStyle.body.bold
                                .foregroundColor((information != nil) ? .txt.primary : .txt.secondary)
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
                    Divider()
                    VStack(alignment: .leading, spacing: 15) {
                        Text("관련 정보")
                            .textStyle.body.bold
                            .foregroundColor(.txt.primary)
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 4) {
                                Image(Asset.address)
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                Text(address)
                            }
                            HStack(spacing: 4) {
                                Image(Asset.call)
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                Text(phonenum)
                            }
                            HStack(spacing: 4) {
                                Image(Asset.url)
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                Text(url)
                            }
                        }
                        .textStyle.body.default
                        .foregroundColor(.txt.quartemary)
                    }
                    Divider()
                    VStack(alignment: .leading, spacing: 15) {
                        Text("올라간 피드")
                            .textStyle.body.bold
                            .foregroundColor(.txt.primary)
                        
                        if feed {
                            ForEach(0..<7) { _ in
                                HomeFeedCell(
                                    name: "JK",
                                    fllows: 100
                                )
                            }
                        } else {
                            Button(action: {}) {
                                VStack(spacing: 3) {
                                    Image(systemName: "plus.app.fill")
                                        .resizable()
                                        .foregroundColor(.icon.quartemary)
                                        .frame(width: 80, height: 80)
                                        .padding(.bottom, 10)
                                    Text("현재 등록된 피드가 없습니다!")
                                    Text("장소에 갔다와 피드를 추가해보세요.")
                                }
                                .textStyle.body.default
                                .foregroundColor(.txt.tertiary)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 40)
                                .background(Color.g[500])
                                .cornerRadius(15)
                            }
                        }
                    }
                }
                .padding(.vertical, 28)
                .padding(.horizontal, 41)
                .toolbar {
                    PLEPToolbarBackButton(
                        action: { dismiss() },
                        title: String(title)+" 정보"
                    )
                }
            }
        }
    }
}
