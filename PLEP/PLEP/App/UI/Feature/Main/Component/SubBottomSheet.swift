//
//  ShareCustomBottomSheet.swift
//  PLEP
//
//  Created by 이다경 on 6/6/25.
//

import SwiftUI

struct SubBottomSheet<Content: View>: View {
    @State private var offset: CGFloat = UIScreen.main.bounds.height * 0.878
    @State private var dragAmount: CGFloat = 0

    var sheetContent: Content

    init(
        @ViewBuilder content: () -> Content
    ) {
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
                    Color.g[0]
                        .cornerRadius(20)
                        .shadow(radius: 5)

                    VStack(spacing: 0) {
                        Capsule()
                            .foregroundColor(.g[500])
                            .frame(width: 64, height: 1)
                            .padding(.vertical, 20)

                        sheetContent

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
                                } else if newOffset > totalHeight * 0.878 {
                                    offset = totalHeight * 0.878
                                } else {
                                    offset = totalHeight * 0.5
                                }
                                dragAmount = 0
                            }
                        }
                )
            }
        }
        .ignoresSafeArea()
    }
}
