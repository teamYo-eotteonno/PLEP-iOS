//
//  TravelFeedCreateView.swift
//  PLEP
//
//  Created by 이다경 on 6/9/25.
//

import SwiftUI
import FlowKit

struct TravelFeedCreateView: View {
    @Flow var flow
    @State private var showCategory = false
    @State private var showCalendar = false
    
    var today: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: Date())
    }
    
    @State private var content = ""
    
    var body: some View {
        ZStack {
            Color.g[50].ignoresSafeArea()
            VStack(spacing: 0) {
                PLEPTopbar(type: .text("피드 생성"), action: { flow.pop() })
                
                Button(action: {}) {
                    VStack(spacing: 5) {
                        Image(Asset.Img.add)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.blue)
                        Text("이미지 추가")
                            .textStyle.body.bold
                            .foregroundColor(.txt.quartemary)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 378)
                    .background(Color.g[100])
                }
                
                CategoryAdd(null: true, onCategory: { showCategory.toggle() })
                
                VStack(spacing: 21) {
                    VStack(spacing: 12) {
                        HStack(spacing: 10) {
                            Button(action: { showCalendar.toggle() }) {
                                HStack(spacing: 5) {
                                    Image(Asset.Calendar.default)
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                    Text(today)
                                        .textStyle.body.bold
                                        .foregroundColor(.txt.tertiary)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(Color.g[200])
                                .cornerRadius(15)
                            }
                            
                            Button(action: {  }) {
                                HStack(spacing: 5) {
                                    Image(Asset.Address.default)
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                    Text("위치 추가")
                                        .textStyle.body.bold
                                        .foregroundColor(.txt.tertiary)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(Color.g[200])
                                .cornerRadius(15)
                            }
                        }
                        
                        PLEPTextField(
                            text: $content,
                            placeholder: "내용을 입력해주세요.",
                            isSecure: false,
                            errorMessage: "내용을 입력해주세요.",
                            intro: true
                        )
                    }
                    PLEPButton(
                        title: "피드 생성",
                        type: .filled,
                        size: .small,
                        enabled: true,
                        icon: Asset.plus,
                        action: {}
                    )
                }
                .padding(.top, 21)
                .padding(.horizontal, 25)
            }
            .sheet(isPresented: $showCategory) {
                ZStack {
                    Color.g[0]
                        .cornerRadius(20)
                        .shadow(radius: 5)
                    
                    VStack(spacing: 0) {
                        Capsule()
                            .foregroundColor(.g[500])
                            .frame(width: 64, height: 1)
                            .padding(.vertical, 20)
                        
                        CategorySheet()
                        
                    }
                }
                .presentationDetents([.fraction(0.59)])
                .presentationDragIndicator(.hidden)
            }
            
            if showCalendar {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showCalendar = false
                    }
                
                FeedCalendar()
                    .padding(.horizontal, 25)
            }
        }
    }
}

#Preview {
    TravelFeedCreateView()
}
