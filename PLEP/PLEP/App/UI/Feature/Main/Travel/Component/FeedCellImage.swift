//
//  FeedCellImage.swift
//  PLEP
//
//  Created by 이다경 on 6/7/25.
//

import SwiftUI

struct FeedCellImage: View {
    let imagePaths: [String]
    let isEditable: Bool
    @State private var feedIndex: Int = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $feedIndex) {
                ForEach(imagePaths.indices, id: \.self) { index in
                    AsyncImage(url: URL(string: imagePaths[index])) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, maxHeight: 378)
                            .clipped()
                    } placeholder: {
                        Rectangle()
                            .fill(Color.g[100])
                            .frame(height: 378)
                    }
                    .tag(index)
                }

                if isEditable {
                    VStack(spacing: 5) {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(.blue)
                        Text("이미지 추가")
                            .textStyle.body.bold
                            .foregroundColor(.txt.quartemary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.width)
                    .background(Color.g[100])
                    .tag(imagePaths.count)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)

            HStack {
                if feedIndex > 0 {
                    Button(action: {
                        withAnimation {
                            feedIndex -= 1
                        }
                    }) {
                        Image(systemName: "chevron.left.circle.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.icon.white)
                            .shadow(radius: 4)
                    }
                    .padding(.leading, 15)
                } else {
                    Spacer().frame(width: 46)
                }

                Spacer()

                if feedIndex < imagePaths.count + (isEditable ? 0 : -1) {
                    Button(action: {
                        withAnimation {
                            feedIndex += 1
                        }
                    }) {
                        Image(systemName: "chevron.right.circle.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.icon.white)
                            .shadow(radius: 4)
                    }
                    .padding(.trailing, 15)
                } else {
                    Spacer().frame(width: 46)
                }
            }
            .frame(height: UIScreen.main.bounds.width)

            VStack {
                Text("\(min(feedIndex + 1, imagePaths.count + (isEditable ? 1 : 0))) / \(imagePaths.count + (isEditable ? 1 : 0))")
                    .textStyle.title.pre
                    .foregroundColor(.icon.white)
                    .padding(8)
                    .background(Color.black.opacity(0.4))
                    .cornerRadius(8)
                    .padding(.bottom, 20)
            }
        }
    }
}

