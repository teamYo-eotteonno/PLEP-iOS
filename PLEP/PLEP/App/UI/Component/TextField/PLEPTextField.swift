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
    var isSecure: Bool = false
    var validate: ((String) -> Bool)? = nil
    var errorMessage: String
    var icon: Bool?
    
    @FocusState private var isFocused: Bool
    @State private var fieldType: PLEPTextFieldType = .null
    @State private var showPassword = false
    
    private var style: PLEPTextFieldStyle {
        PLEPTextFieldStyle(type: fieldType)
    }
        
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .padding(.leading, 18)
                        .textStyle.body.default
                        .foregroundColor(.txt.quartemary)
                        .padding(.bottom, fieldType == .error ? 20 : 0)
                }
                
                if fieldType == .error {
                    Text("*" + errorMessage)
                        .textStyle.body.small
                        .foregroundColor(.s.error)
                        .padding(.leading, 18)
                        .padding(.top, 25)
                }
                
                HStack {
                    Group {
                        if isSecure {
                            if showPassword {
                                TextField("", text: $text)
                                    .focused($isFocused)
                                    .padding(.leading, 18)
                                    .textInputAutocapitalization(.never)
                            } else {
                                SecureField("", text: $text)
                                    .focused($isFocused)
                                    .padding(.leading, 18)
                                    .textInputAutocapitalization(.never)
                            }
                        } else {
                            TextField("", text: $text)
                                .focused($isFocused)
                                .padding(.leading, 18)
                                .textInputAutocapitalization(.never)
                        }
                    }
                    .accentColor(.p[500])
                    .foregroundColor(.txt.primary)
                    .frame(maxWidth: .infinity)
                    .frame(height: fieldType == .error ? 64 : 48)
                    Spacer()
                    
                    if isSecure {
                        Button(action: {
                            showPassword.toggle()
                        }) {
                            Image(systemName: showPassword ? "eye" : "eye.slash")
                                .foregroundColor(.icon.quartemary)
                                .padding(.trailing, 18)
                        }
                    }
                    
                    if icon ?? false {
                        Button(action: {
                            showPassword.toggle()
                        }) {
                            Image(Asset.Search.default)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .padding(.trailing, 18)
                        }
                    }
                    
                }
            }
            .background(Color.g[100])
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

