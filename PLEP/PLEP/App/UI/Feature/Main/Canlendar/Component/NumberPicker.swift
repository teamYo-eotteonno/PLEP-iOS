//
//  NumberPicker.swift
//  PLEP
//
//  Created by 이다경 on 6/11/25.
//

import SwiftUI

struct NumberPicker: View {
    let range: ClosedRange<Int>
    @Binding var selectedNumber: Int

    var body: some View {
        Picker("", selection: $selectedNumber) {
            ForEach(range, id: \.self) { number in
                Text(number < 10 ? "\(number)" : String(number))
                    .textStyle.title.header3
                    .foregroundColor(.txt.primary)
            }
        }
        .frame(width: 70, height: 120)
        .pickerStyle(.wheel)
    }
}
