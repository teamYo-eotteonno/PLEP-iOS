//
//  PLEPSingleTextFieldGroup.swift
//  PLEP
//
//  Created by 이다경 on 5/10/25.
//

import SwiftUI

struct PLEPSingleTextFieldGroup: View {
    @Binding var inputs: [Int]
    @FocusState private var focusedIndex: Int?
    let limit: Int

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ForEach(0..<inputs.count, id: \.self) { i in
                    PLEPSingleTextField(
                        input: Binding(
                            get: { inputs[i] == 0 ? "" : String(inputs[i]) },
                            set: { newValue in
                                // 입력값이 숫자이면 업데이트, 아니면 0으로
                                inputs[i] = Int(newValue) ?? 0
                            }
                        ),
                        index: i,
                        totalCount: inputs.count,
                        focusedIndex: $focusedIndex
                    )
                }
            }
            .frame(maxWidth: .infinity)
            .onAppear {
                focusedIndex = 0
            }
            PLEPCountdown(limitInSeconds: limit)
        }
    }
}
