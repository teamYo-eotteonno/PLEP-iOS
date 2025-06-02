//
//  LoadingView.swift
//  PLEP
//
//  Created by 이다경 on 6/1/25.
//

import SwiftUI

struct SearchingLoadingView: View {
    var body: some View {
        ZStack {
            Color.g[0].ignoresSafeArea()
            VStack(spacing: 16) {
                Image(Asset.travel)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 323)
                VStack(spacing: 10) {
                    Text("LOADING...")
                        .textStyle.title.header3
                        .foregroundColor(.txt.primary)
                    VStack {
                        HStack(spacing: 0) {
                            Text("웨이와 로케가 ")
                            Text("그림 일기")
                                .foregroundColor(.p[500])
                            Text("를 열어보며")
                        }
                        Text("장소를 탐색 중입니다!")
                    }
                    .textStyle.body.bold
                    .foregroundColor(.txt.secondary)
                }
            }
        }
    }
}

#Preview {
    SearchingLoadingView()
}
