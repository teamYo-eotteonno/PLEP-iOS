//
//  SearchingResultView.swift
//  PLEP
//
//  Created by 이다경 on 6/2/25.
//

import SwiftUI

struct SearchingResultView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 10, height: 16)
                            .foregroundColor(.icon.tertiary)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 15)
                .padding(.top, 50)
                .padding(.leading, 35)
                .background(Color.g[0])
                Spacer()
            }
            .ignoresSafeArea()
            
            CustomBottomSheet {
                AiSearchingSheet()
            }
        }
    }
}

#Preview {
    SearchingResultView()
}
