//
//  PLEPCountdown.swift
//  PLEP
//
//  Created by 이다경 on 5/10/25.
//

import SwiftUI

struct PLEPCountdown: View {
    let limitInSeconds: Int
    @State private var remainingSeconds: Int
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(limitInSeconds: Int) {
        self.limitInSeconds = limitInSeconds
        _remainingSeconds = State(initialValue: limitInSeconds)
    }

    var formattedTime: String {
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    var body: some View {
        Text("*남은 시간 \(formattedTime)")
            .textStyle(TextStyle.caption1.default)
            .foregroundColor(.s["error"])
            .onReceive(timer) { _ in
                if remainingSeconds > 0 {
                    remainingSeconds -= 1
                }
            }
    }
}
