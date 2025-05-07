//
//  PLEPOption.swift
//  PLEP
//
//  Created by 이다경 on 4/13/25.
//

import SwiftUI

struct PLEPOption: View {
    let title: String
    let type: PLEPOptionType
    let state: Bool

    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                ZStack {
                    Circle()
                        .frame(width: 16, height: 16)
                        .foregroundColor(style.backgroundColor)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(style.borderColor, lineWidth: style.borderWidth)
                        )
                    
                    if type == .outlined {
                        if state {
                            Image(Asset.Check.gray)
                                .resizable()
                                .frame(width: 8, height: 6)
                        } else {
                            Image(Asset.Check.gray)
                                .resizable()
                                .frame(width: 8, height: 6)
                                .opacity(0.4)
                        }
                    } else {
                        Image(Asset.Check.white)
                            .resizable()
                            .frame(width: 8, height: 6)
                    }
                }

                Text(title)
                    .textStyle(TextStyle.body.bold)
//                    .foregroundColor(.txtop.black.primary)

                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
//        .padding(.leading)
    }

    private var style: PLEPOptionStyle {
        PLEPOptionStyle(type: type, state: state)
    }
}
