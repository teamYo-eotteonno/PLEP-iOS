//
//  ColorTestView.swift
//  PLEP
//
//  Created by 이다경 on 4/12/25.
//

import SwiftUI

struct ColorTestView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                
                HStack(spacing: 0) {
                    ColorCeil(.p[50])
                    ColorCeil(.p[100])
                    ColorCeil(.p[200])
                    ColorCeil(.p[300])
                    ColorCeil(.p[400])
                    ColorCeil(.p[500])
                    ColorCeil(.p[600])
                    ColorCeil(.p[700])
                    ColorCeil(.p[800])
                    ColorCeil(.p[900])
                }
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                .padding(.horizontal, 10)

                HStack(spacing: 0) {
                    ColorCeil(.g[0])
                    ColorCeil(.g[50])
                    ColorCeil(.g[100])
                    ColorCeil(.g[200])
                    ColorCeil(.g[300])
                    ColorCeil(.g[400])
                    ColorCeil(.g[500])
                    ColorCeil(.g[600])
                    ColorCeil(.g[700])
                    ColorCeil(.g[800])
                    ColorCeil(.g[900])
                }
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                .padding(.horizontal, 10)

                HStack(spacing: 0) {
                    ColorCeil(.s.success)
                    ColorCeil(.s.error)
                    ColorCeil(.s.warning)
                }
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                .padding(.horizontal, 10)

                HStack(spacing: 0) {
                    ColorCeil(.txt.primary)
                    ColorCeil(.txt.secondary)
                    ColorCeil(.txt.tertiary)
                    ColorCeil(.txt.quartemary)
                }
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                .padding(.horizontal, 10)

                HStack(spacing: 0) {
                    ColorCeil(.icon.primary)
                    ColorCeil(.icon.secondary)
                    ColorCeil(.icon.tertiary)
                    ColorCeil(.icon.quartemary)
                }
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                .padding(.horizontal, 10)

                HStack(spacing: 0) {
                    ColorCeil(.file.red)
                    ColorCeil(.file.orange)
                    ColorCeil(.file.yellow)
                    ColorCeil(.file.lame)
                    ColorCeil(.file.green)
                    ColorCeil(.file.sky)
                    ColorCeil(.file.blue)
                    ColorCeil(.file.purple)
                    ColorCeil(.file.magenta)
                    ColorCeil(.file.pink)
                }
                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                .padding(.horizontal, 10)
            }
        }
    }
}

struct ColorCeil: View {
    let color: Color

    init(_ color: Color) {
        self.color = color
    }

    var body: some View {
        Rectangle()
            .frame(height: 160)
            .foregroundStyle(color)
    }
}

#Preview {
    ColorTestView()
}
