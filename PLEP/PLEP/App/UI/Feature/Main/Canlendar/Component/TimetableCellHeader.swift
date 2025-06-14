//
//  ScheduleCellHeader.swift
//  PLEP
//
//  Created by 이다경 on 6/11/25.
//

import SwiftUI

enum TimetableCellHeaderSize {
    case `default`, small
}

struct TimetableCellHeader: View {
    let size: TimetableCellHeaderSize
    let num: Int
    @Binding var isExpanded: Bool
    
    var body: some View {
        Button(action: {
            withAnimation {
                isExpanded.toggle()
            }
        }) {
            switch size {
            case.default:
                HStack {
                    Text(String(num)+"일차")
                        .textStyle.body.small
                        .foregroundColor(.icon.tertiary)
                    Text("8.24(일)")
                        .textStyle.body.small
                        .foregroundColor(.icon.tertiary)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .resizable()
                        .frame(width: 13, height: 7)
                        .foregroundColor(.icon.tertiary)
                }
                .padding(.vertical, 15)
                .padding(.horizontal, 20)
                .background(Color.g[0])
                .cornerRadius(10)
                
            case.small:
                VStack(spacing: 0) {
                    HStack {
                        Text(String(num)+"일차")
                            .textStyle.body.small
                            .foregroundColor(.icon.tertiary)
                        Text("8.24(일)")
                            .textStyle.body.small
                            .foregroundColor(.icon.tertiary)
                        Spacer()
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .resizable()
                            .frame(width: 13, height: 7)
                            .foregroundColor(.icon.tertiary)
                    }
                    .padding(.vertical, 7)
                    .padding(.horizontal, 20)
                    .background(Color.g[0])
                    PLEPDivider(type: .g200)
                }
            }
        }
    }
}
