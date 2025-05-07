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
    var iconName: String? = nil
    var isSecure: Bool = false
    var validate: ((String) -> Bool)? = nil
    var errorMessage: String

    @FocusState private var isFocused: Bool
    @State private var fieldType: PLEPTextFieldType = .null
    @State private var showPassword = false

    private var style: PLEPTextFieldStyle {
        PLEPTextFieldStyle(color: color, type: fieldType, login: login)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .padding(.leading, login && iconName != nil ? 44 : 18)
                        .foregroundColor(.txt["quarternary"])
                        .textStyle.body.default
                        .padding(.bottom, fieldType == .error ? 20 : 0)
                }

                if fieldType == .error {
                    Text("*" + errorMessage)
                        .padding(.leading, 18)
                        .foregroundColor(.s["error"])
                        .textStyle(TextStyle.caption2.default)
                        .padding(.top, 25)
                }

                HStack(spacing: 5) {
                    if login, let iconName = iconName {
                        Image(systemName: iconName)
                            .foregroundColor(style.textColor)
                            .padding(.leading)
                    }

                    Group {
                        if isSecure {
                            if showPassword {
                                TextField("", text: $text)
                                    .focused($isFocused)
                                    .padding(.leading)
                            } else {
                                SecureField("", text: $text)
                                    .focused($isFocused)
                                    .padding(.leading)
                            }
                        } else {
                            TextField("", text: $text)
                                .focused($isFocused)
                                .padding(.leading)
                        }
                    }
                    .accentColor(.p[500])
                    .foregroundColor(style.textColor)
                    .textStyle.body.default
                    .padding(.bottom, fieldType == .error ? 20 : 0)

                    Spacer()

                    if isSecure {
                        Button(action: {
                            showPassword.toggle()
                        }) {
                            Image(systemName: showPassword ? "eye" : "eye.slash")
                                .foregroundColor(.gray)
                                .padding(.trailing, 12)
                        }
                    }
                }
                .padding(.trailing, isSecure ? 0 : 18)
            }
            .frame(height: fieldType == .error ? 64 : 48)
            .frame(maxWidth: .infinity)
            .background(style.backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(style.borderColor, lineWidth: style.borderWidth)
            )
            .cornerRadius(10)
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
    }
}
