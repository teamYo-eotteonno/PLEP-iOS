//
//  ScheduleCell.swift
//  PLEP
//
//  Created by 이다경 on 6/18/25.
//

import SwiftUI

struct ScheduleCell: View {
    let time: String
    let color: Color
    let title: String
    let alarm: Int
    let onTap: () -> Void
    let onLongPressWithLocation: (CGPoint) -> Void

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 6) {
                HStack(alignment: .top, spacing: 7) {
                    Text(time)
                        .textStyle.body.small
                        .foregroundColor(.txt.primary)
                    Capsule()
                        .frame(width: 5, height: 34)
                        .foregroundColor(color)
                }
                .padding(.vertical, 3)

                VStack(alignment: .leading, spacing: 0) {
                    Text(title)
                        .textStyle.body.bold
                        .foregroundColor(.txt.primary)
                    if alarm != 0 {
                        Text("\(alarm)시간 전 알림")
                            .textStyle.body.small
                            .foregroundColor(.txt.tertiary)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 2)
            .contentShape(Rectangle())
            .gesture(
                LongPressGesture(minimumDuration: 0.4)
                    .sequenced(before: DragGesture(minimumDistance: 0))
                    .onEnded { value in
                        switch value {
                        case .second(true, let drag?):
                            let location = drag.location
                            let globalLocation = CGPoint(
                                x: geometry.frame(in: .global).origin.x + location.x,
                                y: geometry.frame(in: .global).origin.y + location.y
                            )
                            onLongPressWithLocation(globalLocation)
                        default:
                            break
                        }
                    }
            )
            .onTapGesture {
                onTap()
            }
        }
        .frame(height: 40)
    }
}
