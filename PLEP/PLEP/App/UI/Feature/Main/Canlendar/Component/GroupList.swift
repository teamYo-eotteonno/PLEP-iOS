//
//  GroupList.swift
//  PLEP
//
//  Created by 이다경 on 6/17/25.
//

import SwiftUI

struct GroupList: View {
    let groups: [Color: String]
    @Binding var selectedIndex: Int?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                Button(action: {
                    print("그룹 추가")
                }) {
                    VStack(spacing: 5) {
                        Image(Asset.Add.rectangle)
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("추가")
                            .textStyle.title.pre
                            .foregroundColor(.txt.primary)
                    }
                }

                ForEach(Array(groups.enumerated()), id: \.offset) { index, element in
                    let color = element.key
                    let name = element.value

                    Button(action: {
                        selectedIndex = index
                    }) {
                        VStack(spacing: 5) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .foregroundColor(selectedIndex == index ? .p[500] : color)
                                    .frame(width: 20, height: 20)
                                
                                Rectangle()
                                    .fill(color)
                                    .frame(width: 16, height: 16)
                                    .cornerRadius(4)
                            }

                            Text(name)
                                .textStyle.title.pre
                                .foregroundColor(.txt.primary)
                                .lineLimit(1)
                        }
                        .frame(width: 43)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}
