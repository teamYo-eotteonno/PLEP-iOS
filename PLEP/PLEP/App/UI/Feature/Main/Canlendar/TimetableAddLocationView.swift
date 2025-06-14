//
//  TimetableAddLocationView.swift
//  PLEP
//
//  Created by 이다경 on 6/15/25.
//

import SwiftUI

struct TimetableAddLocationView: View {
    var body: some View {
        ZStack {
            
            MainBottomSheet(showButton: false) { PlacesListSheet() }
        }
    }
}

#Preview {
    TimetableAddLocationView()
}
