//
//  CharPicker.swift
//  PLEP
//
//  Created by 이다경 on 6/11/25.
//

import SwiftUI

struct CharPicker: View {
    @Binding var isPM: Bool
    private let range = ["오전", "오후"]

    var body: some View {
        Picker("", selection: Binding<String>(
            get: { isPM ? "오후" : "오전" },
            set: { isPM = ($0 == "오후") }
        )) {
            ForEach(range, id: \.self) { char in
                Text(char)
                    .textStyle.body.bold
                    .foregroundColor(.txt.primary)
            }
        }
        .frame(width: 60, height: 120)
        .pickerStyle(.wheel)
    }
}
