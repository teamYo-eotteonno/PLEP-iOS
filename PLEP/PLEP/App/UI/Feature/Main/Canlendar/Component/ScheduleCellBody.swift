//
//  ScheduleCellBody.swift
//  PLEP
//
//  Created by 이다경 on 6/11/25.
//

import SwiftUI

struct ScheduleCellBody: View {
    @State var isChecked = false
    let place: String
    let address: String
    let touch: Bool
    
    var body: some View {
        HStack {
            HStack(alignment: .top, spacing: 12) {
                Checkbox(isChecked: $isChecked)
                    .padding(.top, 3.5)
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 5) {
                        Text(place)
                            .textStyle.body.bold
                            .foregroundColor(.txt.primary)
                            .strikethrough(isChecked ? true : false)
                        Text(address)
                            .textStyle.title.pre
                            .foregroundColor(.txt.quartemary)
                            .strikethrough(isChecked ? true : false)
                    }
                    Text("4:00")
                        .textStyle.body.small
                        .foregroundColor(.txt.tertiary)
                }
            }
            Spacer()
            Image(Asset.menu)
                .resizable()
                .frame(width: 15, height: 18)
        }
        .padding(touch ? 25 : 15)
        .cornerRadius(touch ? 20 : 0)
        .background(Color.g[0])
    }
}

#Preview {
    ScheduleCellBody(place: "방탄소년단", address: "빅히트 본사", touch: false)
    ScheduleCellBody(place: "방탄소년단", address: "빅히트 본사", touch: true)
}
