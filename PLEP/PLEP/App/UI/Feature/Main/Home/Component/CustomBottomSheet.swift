//
//  CustomBottomSheet.swift
//  PLEP
//
//  Created by 이다경 on 6/2/25.
//

import SwiftUI

struct CustomBottomSheet<Content: View>: View {
    @State private var offset: CGFloat = UIScreen.main.bounds.height * 0.5
    @State private var dragAmount: CGFloat = 0

    var sheetContent: Content
    var showButton: Bool

    init(
        showButton: Bool = false,
        @ViewBuilder content: () -> Content
    ) {
        self.showButton = showButton
        self.sheetContent = content()
    }

    var body: some View {
        let totalHeight = UIScreen.main.bounds.height
        let currentOffset = offset + dragAmount
        let currentHeight = totalHeight - currentOffset
        let isOver60 = currentHeight > totalHeight * 0.6

        ZStack(alignment: .top) {
            VStack {
                ZStack {
                    Color.g[50]
                        .cornerRadius(20)
                        .shadow(radius: 5)

                    VStack(spacing: 0) {
                        Capsule()
                            .foregroundColor(.g[500])
                            .frame(width: 64, height: 1)
                            .padding(.vertical, 20)

                        sheetContent

                        Spacer(minLength: 40)
                    }
                }
                .frame(height: totalHeight)
                .offset(y: currentOffset)
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

            if showButton {
                if isOver60 {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            PLEPButton(
                                title: "함께 장소 공유하기",
                                type: .outlined,
                                size: .small,
                                enabled: true,
                                icon: Asset.User.Users.color,
                                action: {}
                            )
                            .frame(width: 183)
                        }
                        .padding(.trailing, 25)
                        .padding(.bottom, 100)
                    }
                    .ignoresSafeArea()
                } else {
                    HStack {
                        PLEPButton(
                            title: "함께 장소 공유하기",
                            type: .outlined,
                            size: .small,
                            enabled: true,
                            icon: Asset.User.Users.color,
                            action: {}
                        )
                        .frame(width: 183)
                        .padding(.leading, 25)
                        .offset(y: currentOffset - 65)
                        .animation(.easeInOut, value: currentOffset)
                        Spacer()
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}
