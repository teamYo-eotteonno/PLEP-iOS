//
//  SearchingResultView.swift
//  PLEP
//
//  Created by 이다경 on 6/2/25.
//

import SwiftUI
import FlowKit

struct SearchingResultView: View {
    @Flow var flow
    var body: some View {
        ZStack {
            VStack {
                PLEPTopbar(type: .default, action: { flow.pop() })
                Spacer()
            }
            
            MainBottomSheet { AiSearchingSheet() }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    SearchingResultView()
}
