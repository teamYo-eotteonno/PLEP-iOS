//
//  TimeWheel.swift
//  PLEP
//
//  Created by 이다경 on 6/16/25.
//

import SwiftUI

struct TimeWheel: View {
    @Binding var isPM: Bool
    @Binding var hour: Int
    @Binding var minute: Int
    var onTimeChange: ((String) -> Void)? = nil

    var body: some View {
        HStack(spacing: 20) {
            // 오전/오후 선택 휠
            Picker("", selection: $isPM) {
                Text("오전").tag(false)
                Text("오후").tag(true)
            }
            .frame(width: 60, height: 120)
            .pickerStyle(.wheel)
            .onChange(of: isPM) { _ in updateTime() }

            HStack(spacing: 5) {
                NumberPicker(range: 1...12, selectedNumber: $hour)
                    .onChange(of: hour) { _ in updateTime() }

                Text(":")
                    .textStyle.title.header3
                    .foregroundColor(.txt.primary)

                NumberPicker(range: 0...5, selectedNumber: Binding(
                    get: { minute / 10 },
                    set: { newValue in
                        minute = newValue * 10
                        updateTime()
                    })
                )
                NumberPicker(range: 0...9, selectedNumber: Binding(
                    get: { minute % 10 },
                    set: { newValue in
                        minute = (minute / 10) * 10 + newValue
                        updateTime()
                    })
                )
            }
        }
        .padding(.vertical, 20)
        .onAppear {
            updateTime()
        }
    }

    private func updateTime() {
        let h = hour
        let m = String(format: "%02d", minute)
        let ampm = isPM ? "오후" : "오전"
        let timeString = "\(ampm) \(h):\(m)"
        onTimeChange?(timeString)
    }
}
