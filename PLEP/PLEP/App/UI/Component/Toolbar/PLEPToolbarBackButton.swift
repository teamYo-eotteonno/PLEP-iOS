//
//  PLEPToolbarBackButton.swift
//  PLEP
//
//  Created by 이다경 on 4/13/25.
//

import SwiftUI

struct PLEPToolbarBackButton: ToolbarContent {
    let action: () -> Void

    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: action) {
                Image(Asset.Back.white)
                    .resizable()
                    .frame(width: 23, height: 23)
                    .padding(.leading, 10)
            }
        }
    }
}
