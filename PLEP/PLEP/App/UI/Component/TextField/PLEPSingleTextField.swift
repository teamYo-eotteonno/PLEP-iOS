//
//  PLEPSingleTextField.swift
//  PLEP
//
//  Created by 이다경 on 5/9/25.
//

import SwiftUI

struct PLEPSingleTextField: View {
    @Binding var input: String
    var nextField: FocusState<Field?>.Binding
    var currentField: Field

    var body: some View {
        TextField("", text: $input)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .focused(nextField, equals: currentField)
            .onChange(of: input) { newValue in
                if let firstChar = newValue.first, firstChar.isNumber {
                    input = String(firstChar)
                    nextField.wrappedValue = currentField.next
                } else {
                    input = ""
                }
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(width: 40)
    }
}

enum Field: Int, CaseIterable {
    case first, second, third

    var next: Field? {
        let all = Field.allCases
        let nextIndex = all.firstIndex(of: self)! + 1
        return nextIndex < all.count ? all[nextIndex] : nil
    }
}

struct PLEPTextFieldGroup: View {
    @State private var inputs = ["", "", ""]
    @FocusState private var focusedField: Field?

    var body: some View {
        HStack {
            ForEach(Field.allCases.indices, id: \.self) { index in
                PLEPSingleTextField(
                    input: $inputs[index],
                    nextField: $focusedField,
                    currentField: Field.allCases[index]
                )
            }
        }
        .onAppear {
            focusedField = .first
        }
    }
}

#Preview {
    PLEPTextFieldGroup()
}
