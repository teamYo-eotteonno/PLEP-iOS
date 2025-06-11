//
//  NumberPicker.swift
//  PLEP
//
//  Created by 이다경 on 6/11/25.
//

import SwiftUI

struct NumberPicker: View {
    let range: ClosedRange<Int>
    @State private var selectedNumber: Int
    
    init(range: ClosedRange<Int>) {
        self.range = range
        _selectedNumber = State(initialValue: range.lowerBound)
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Picker("", selection: $selectedNumber) {
                    ForEach(range, id: \.self) { number in
                        Text("\(number)")
                            .textStyle.title.header3
                            .foregroundColor(.txt.primary)
                    }
                }
                .frame(width: 70, height: 120)
                .pickerStyle(.wheel)
            }
        }
    }
}
