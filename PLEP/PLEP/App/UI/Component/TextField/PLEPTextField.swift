//
//  PLEPTextField.swift
//  PLEP
//
//  Created by 이다경 on 4/11/25.
//

import SwiftUI

struct PLEPTextField: View {
    @Binding var text: String
    var placeholder: String
    var color: PLEPTextFieldColor
    var login: Bool
    var isSecure: Bool = false
    var validate: ((String) -> Bool)? = nil
    var errorMessage: String

    @FocusState private var isFocused: Bool
    @State private var fieldType: PLEPTextFieldType = .null

    private var style: PLEPTextFieldStyle {
        PLEPTextFieldStyle(color: color, type: fieldType, login: login)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .padding(.leading, 18)
                        .foregroundColor(.txt["quarternary"])
                        .textStyle.body.default
                        .padding(.bottom, fieldType == .error ? 20 : 0)
                    
                }
                if fieldType == .error {
                    Text("*"+errorMessage)
                        .padding(.leading, 18)
                        .foregroundColor(.s["error"])
                        .textStyle(TextStyle.caption2.default)
                        .padding(.top, 25)
                }

                Group {
                    if isSecure {
                        SecureField("", text: $text)
                            .padding(.leading, 18)
                            .padding(.bottom, fieldType == .error ? 20 : 0)
                            .focused($isFocused)
                            .accentColor(.p[500])
                    } else {
                        TextField("", text: $text)
                            .padding(.leading, 18)
                            .padding(.bottom, fieldType == .error ? 20 : 0)
                            .focused($isFocused)
                            .accentColor(.p[500])
                    }
                }
                .foregroundColor(style.textColor)
                .textStyle.body.default
                .onChange(of: isFocused) { focused in
                    if focused {
                        fieldType = .focus
                    } else {
                        if let validate = validate {
                            fieldType = validate(text) ? .in : .error
                        } else {
                            fieldType = text.isEmpty ? .null : .in
                        }
                    }
                }
            }
            .frame(height: fieldType == .error ? 64 : 48)
            .frame(maxWidth: .infinity)
            .background(style.backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(style.borderColor, lineWidth: style.borderWidth)
            )
            .cornerRadius(10)
        }
    }
}
