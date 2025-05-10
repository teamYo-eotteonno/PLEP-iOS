//
//  PLEPSingleTextFieldGroup.swift
//  PLEP
//
//  Created by 이다경 on 5/10/25.
//

import SwiftUI

struct PLEPSingleTextFieldGroup: View {
    @Binding var inputs: [String]
    @FocusState private var focusedIndex: Int?
    let limit: Int

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ForEach(0..<inputs.count, id: \.self) { i in
                    PLEPSingleTextField(
                        input: $inputs[i],
                        index: i,
                        totalCount: inputs.count,
                        focusedIndex: $focusedIndex
                    )
                }
            }
            .onAppear {
                focusedIndex = 0
            }
            PLEPCountdown(limitInSeconds: limit)
        }
    }
}
