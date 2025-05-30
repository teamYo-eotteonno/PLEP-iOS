//
//  HomeView.swift
//  PLEP
//
//  Created by 이다경 on 5/29/25.
//

import SwiftUI

struct HomeView: View {
    @State private var showingSheet = false
    
    var body: some View {
        VStack {
            Button("Show Sheet") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                PlaceInformationSheet(
                    title: "방탄소년단",
                    name: "BTS",
                    category: "아이돌",
                    information: "세계적인 아티스트",
                    feednum: 99,
                    address: "빅히트 본사",
                    phonenum: "010-1234-1234",
                    url: "http://www.bighit.com",
                    feed: false
                )
            }
        }
    }
}

#Preview {
    HomeView()
}
