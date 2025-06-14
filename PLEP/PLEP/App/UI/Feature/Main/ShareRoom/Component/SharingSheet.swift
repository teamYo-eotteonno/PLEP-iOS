//
//  SharingSheet.swift
//  PLEP
//
//  Created by 이다경 on 6/4/25.
//

import SwiftUI

struct SharingSheet: View {
    @State private var url = "https://youtu.be/BMbKLEyDK-o?si=wdqcRsm89f8DckOe"
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 17) {
                Text("공유")
                    .textStyle.body.bold
                    .foregroundColor(.txt.primary)
                PLEPDivider(type: .g200)
            }
            PLEPTextField(
                text: $url,
                placeholder: "",
                errorMessage: "",
                icon_l: true,
                action: {}
            )
            
            HStack{
                ForEach(SharingSheetCellType.allCases, id: \.self) { type in
                    Spacer()
                    SharingSheetCell(type: type, action: {})
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 41)
        .padding(.bottom, 45)
        .background(Color.g[0])
    }
}
