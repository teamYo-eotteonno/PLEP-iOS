//
//  HomeView.swift
//  PLEP
//
//  Created by 이다경 on 5/29/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            
            MainBottomSheet(showButton: true) { PlacesListSheet() }
        }
    }
}

#Preview {
    HomeView()
}
