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
                PLEPTopbar(type: .default, action: {})
                Spacer()
            }
            
            CustomBottomSheet {
                AiSearchingSheet()
            }
        }
    }
}

#Preview {
    SearchingResultView()
}
