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
    @State private var dragAmount: CGFloat = 0
    
    var body: some View {
        let totalHeight = UIScreen.main.bounds.height
        let currentHeight = totalHeight - (offset + dragAmount)
        let isOver60 = currentHeight > totalHeight * 0.6
        
        VStack {
            ZStack {
                Color.white
                    .cornerRadius(20)
                    .shadow(radius: 5)
                
                VStack(spacing: 0) {
                    VStack {
                        Capsule()
                            .foregroundColor(.g[500])
                            .frame(width: 64, height: 1)
                            .padding(.top, 20)
                    }
                    
                    ZStack {
                        // 콘텐츠 뷰
                         PlacesListSheet()
                        
                        // 버튼: 위치 조건에 따라 다르게 배치
                        if isOver60 {
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    button
                                }
                            }
                            .padding()
                        } else {
                            VStack {
                                HStack {
                                    button
                                    Spacer()
                                }
                                Spacer()
                            }
                            .padding()
                        }
                    }
                }
            }
            .frame(height: totalHeight)
            .offset(y: offset + dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragAmount = value.translation.height
                    }
                    .onEnded { value in
                        let newOffset = offset + value.translation.height
                        withAnimation(.easeInOut) {
                            if newOffset < totalHeight * 0.4 {
                                offset = totalHeight * 0.2
                            } else if newOffset > totalHeight * 0.7 {
                                offset = totalHeight * 0.7
                            } else {
                                offset = totalHeight * 0.5
                            }
                            dragAmount = 0
                        }
                    }
            )
        }
        .ignoresSafeArea()
    }
    
    // 버튼 정의
    var button: some View {
        VStack {
            PLEPButton(
                title: "함께 장소 공유하기",
                type: .outlined,
                size: .small,
                enabled: true,
                icon: Asset.users,
                action: {}
            )
        }
        .frame(width: 183)
    }
}




#Preview {
    HomeView()
}
