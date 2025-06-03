//
//  PLEPToolbarBackButton.swift
//  PLEP
//
//  Created by 이다경 on 4/13/25.
//

import SwiftUI

struct PLEPToolbar: ToolbarContent {
    let action: () -> Void
    var title: String?

    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: action) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .foregroundColor(.txt.primary)
                    .frame(width: 10, height: 16)
                    .padding(.leading, 10)
                
                if (title != nil) {
                    Text(title ?? "")
                        .textStyle.body.bold
                        .foregroundColor(.txt.primary)
                }
            }
        }
    }
}
