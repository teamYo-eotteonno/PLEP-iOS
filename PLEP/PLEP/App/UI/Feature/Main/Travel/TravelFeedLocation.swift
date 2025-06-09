//
//  TravelFeedLocation.swift
//  PLEP
//
//  Created by 이다경 on 6/9/25.
//

import SwiftUI

struct TravelFeedLocation: View {
    var body: some View {
        ZStack {
            
            MainBottomSheet(showButton: false) { PlacesListSheet() }
        }
    }
}

#Preview {
    TravelFeedLocation()
}
