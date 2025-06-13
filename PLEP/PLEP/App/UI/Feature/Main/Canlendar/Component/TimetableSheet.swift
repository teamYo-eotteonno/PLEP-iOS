//
//  TimeTableSheet.swift
//  PLEP
//
//  Created by 이다경 on 6/13/25.
//

import SwiftUI

struct TimetableSheet: View {
    let place: String
    let time: String
    let address: String
    let note: String
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text("시간표 정보")
                        .textStyle.body.bold
                        .foregroundColor(.txt.primary)
                    Spacer()
                    HStack(spacing: 5) {
                        PLEPButton(
                            title: "삭제",
                            type: .neutral,
                            size: .small,
                            enabled: true,
                            action: {}
                        )
                        
                        PLEPButton(
                            title: "수정",
                            type: .outlined,
                            size: .small,
                            enabled: true,
                            action: {}
                        )
                    }
                    .frame(width: 141)
                }
                
                PLEPDivider(type: .g200)
                
                VStack(alignment: .leading, spacing: 5) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(place)
                            .textStyle.title.header3
                            .foregroundColor(.txt.primary)
                        HStack(spacing: 5) {
                            Image(Asset.clock)
                                .frame(width: 15, height: 15)
                            Text(time)
                                .textStyle.body.bold
                                .foregroundColor(.txt.primary)
                        }
                    }
                    HStack(spacing: 5) {
                        Image(Asset.Address.default)
                            .frame(width: 15, height: 15)
                        Text(address)
                            .textStyle.body.default
                            .foregroundColor(.txt.quartemary)
                    }
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("메모")
                        .textStyle.body.bold
                    Text(note)
                        .textStyle.body.default
                }
                .foregroundColor(.txt.primary)
            }
            PLEPButton(
                title: "일정 수정하기",
                type: .neutral,
                size: .small,
                enabled: true,
                action: {}
            )
        }
        .padding(.bottom, 45)
        .padding(.horizontal, 25)
        .background(Color.g[0])
    }
}
