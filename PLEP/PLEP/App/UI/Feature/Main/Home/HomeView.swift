//
//  HomeView.swift
//  PLEP
//
//  Created by 이다경 on 5/29/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            Text("배경 내용입니다")
                .font(.largeTitle)
            
            CustomBottomSheet()
        }
    }
}

struct CustomBottomSheet: View {
    @State private var offset: CGFloat = UIScreen.main.bounds.height * 0.5
    @GestureState private var dragOffset: CGFloat = 0

    var body: some View {
        let totalHeight = UIScreen.main.bounds.height
        let currentHeight = totalHeight - (offset + dragOffset)
        let isOver60 = currentHeight > totalHeight * 0.6
        
        VStack {
            ZStack(alignment: isOver60 ? .bottomTrailing : .topLeading) {
                Color.red
                    .cornerRadius(20)
                    .shadow(radius: 10)

                PlaceInformationSheet(
                                    title: "방탄소년단",
                                    name: "BTS",
                                    category: "아이돌",
                                    information: "세계적인 아티스트",
                                    feednum: 99,
                                    address: "빅히트 본사",
                                    phonenum: "010-1234-1234",
                                    url: "http://www.bighit.com",
                                    feed: false
                                )
                
                Button(action: {
                    print("버튼 클릭됨")
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            .frame(height: totalHeight)
            .offset(y: offset + dragOffset)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation.height
                    }
                    .onEnded { value in
                        let newOffset = offset + value.translation.height
                        withAnimation {
                            if newOffset < totalHeight * 0.4 {
                                offset = totalHeight * 0.2 // 위로 확장
                            } else if newOffset > totalHeight * 0.7 {
                                offset = totalHeight * 0.7 // 아래로 축소
                            } else {
                                offset = totalHeight * 0.5 // 중간
                            }
                        }
                    }
            )
        }
        .ignoresSafeArea()
        .animation(.easeInOut, value: offset)
    }
}


#Preview {
    HomeView()
}
