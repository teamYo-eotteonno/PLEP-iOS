//
//  TravelMoreSheet.swift
//  PLEP
//
//  Created by 이다경 on 6/9/25.
//

import SwiftUI

struct TravelMoreSheet: View {
    let onEdit: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        ZStack {
            Color.g[0].ignoresSafeArea()
            VStack(alignment: .leading, spacing: 20) {
                Button(action: { onEdit() }) {
                    HStack(spacing: 5) {
                        Image(Asset.edit)
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("수정")
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 7)
                }
                
                Button(action: { onDelete() }) {
                    HStack(spacing: 5) {
                        Image(Asset.trash)
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("삭제")
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 7)
                }
            }
            .textStyle.body.default
            .foregroundColor(.txt.tertiary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 41)
            .background(Color.g[0])
        }
    }
}

