//
//  CategorySheet.swift
//  PLEP
//
//  Created by 이다경 on 6/8/25.
//

import SwiftUI

struct CategorySheet: View {
    var body: some View {
        VStack(spacing: 55) {
            VStack(spacing: 17) {
                Text("카테고리 선택")
                    .textStyle.body.bold
                    .foregroundColor(.txt.primary)
                
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 1)
                    .foregroundColor(.g[200])
                
                VStack(alignment: .leading, spacing: 25) {
                    ForEach(0..<3) { _ in
                        VStack(alignment: .leading, spacing: 3) {
                            Text("카테고리")
                                .textStyle.body.default
                                .foregroundColor(.txt.primary)
                            HStack {
                                ForEach(0..<3) { _ in
                                    PLEPTag(
                                        title: "💜ARMY",
                                        type: .outlined,
                                        size: .small,
                                        enabled: true
                                    )
                                    
                                }
                                Spacer()
                            }
                        }
                    }
                }
            }
            PLEPButton(
                title: "설정완료",
                type: .neutral,
                size: .small,
                enabled: true,
                action: {}
            )
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 45)
        .padding(.horizontal, 25)
        .background(Color.g[0])
    }
}

#Preview {
    CategorySheet()
}
