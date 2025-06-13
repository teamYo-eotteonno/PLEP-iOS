//
//  PLEPTopbar.swift
//  PLEP
//
//  Created by 이다경 on 6/3/25.
//

import SwiftUI

enum PLEPTopbarType {
    case `default`
    case profile
//    case icon(String)
    case text(String)
}

struct PLEPTopbar: View {
    let type: PLEPTopbarType
    let action: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                    Button(action: action) {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 10, height: 16)
                            .foregroundColor(.icon.tertiary)
                    }
//                    Spacer()
                switch type {
                case .default:
                    Spacer()
                case .profile:
                    Spacer()
                    Button(action: action) {
                        Image(Asset.User.Add.Circle.default)
                            .resizable()
                            .frame(width: 24, height: 24)
                    }

//                case .icon(let text):
                    
                case .text(let text):
                    Text(text)
                        .textStyle.body.bold
                        .foregroundColor(.txt.primary)
                        .padding(.leading, 5)
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .padding(.top, 60)
            .padding(.horizontal, 35)
            .background(Color.g[0])
            .overlay(
                PLEPDivider(type: .g100),
                alignment: .bottom
            )
//            Spacer()
        }
        .ignoresSafeArea()
    }
}

