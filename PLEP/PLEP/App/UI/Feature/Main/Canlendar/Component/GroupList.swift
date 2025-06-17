//
//  GroupList.swift
//  PLEP
//
//  Created by 이다경 on 6/17/25.
//

import SwiftUI

struct GroupList: View {
    let groups: [Color: String]

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
                    
                    VStack(spacing: 5) {
                        Rectangle()
                            .fill(color)
                            .frame(width: 20, height: 20)
                            .cornerRadius(5)

                        Text(name)
                            .textStyle.title.pre
                            .foregroundColor(.txt.primary)
                            .lineLimit(1)
                    }
                    .frame(width: 43)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    GroupList(groups: [
        .red: "팀 Aafdafdfadfa",
        .blue: "가족여행",
        .green: "팀 C"
    ])
}
