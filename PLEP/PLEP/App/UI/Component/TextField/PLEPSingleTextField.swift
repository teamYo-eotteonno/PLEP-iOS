//
//  PLEPSingleTextField.swift
//  PLEP
//
//  Created by 이다경 on 5/9/25.
//

import SwiftUI

struct PLEPSingleTextField: View {
    @Binding var input: String
    var index: Int
    var totalCount: Int
    var focusedIndex: FocusState<Int?>.Binding

    var body: some View {
        TextField("", text: $input)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .focused(focusedIndex, equals: index)
            .onChange(of: input) { newValue in
                if let firstChar = newValue.first, firstChar.isNumber {
                    input = String(firstChar)
                    if index + 1 < totalCount {
                        focusedIndex.wrappedValue = index + 1
                    } else {
                        focusedIndex.wrappedValue = nil
                    }
                } else {
                    input = ""
                }
            }
            .frame(width: 37.5, height: 46)
            .background(Color.g[100])
            .cornerRadius(10)
            .foregroundColor(.txt.primary)
    }
}
