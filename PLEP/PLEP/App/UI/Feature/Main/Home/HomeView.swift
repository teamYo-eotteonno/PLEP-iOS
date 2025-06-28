//
//  HomeView.swift
//  PLEP
//
//  Created by 이다경 on 5/29/25.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Tab = .home
    
    enum Tab {
        case home
        case calendar
        case aiSearch
        case travel
        case profile
    }
    
    var body: some View {
        ZStack {
            // 현재 선택된 탭 뷰
            Group {
                switch selectedTab {
                case .home:
                    Text("Home View")
                case .calendar:
                    Text("Calendar View")
                case .aiSearch:
                    Text("AI Search View")
                case .travel:
                    Text("Travel View")
                case .profile:
                    Text("Profile View")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.edgesIgnoringSafeArea(.all))
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    // 홈
                    tabBarItem(tab: .home, imageName: "house", title: "홈")
                    
                    Spacer()
                    
                    // 일정
                    tabBarItem(tab: .calendar, imageName: "calendar", title: "일정")
                    
                    Spacer()
                    
                    // 중앙 AI 서칭 버튼
                    ZStack {
                        Circle()
                            .fill(Color.purple)
                            .frame(width: 70, height: 70)
                            .shadow(radius: 5)
                        Button(action: {
                            selectedTab = .aiSearch
                        }) {
                            VStack {
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                                if selectedTab == .aiSearch {
                                    Text("AI 서칭")
                                        .font(.caption)
                                        .foregroundColor(.white)
                                }
                            }
                        }
                    }
                    .offset(y: -20)
                    
                    Spacer()
                    
                    // 여행
                    tabBarItem(tab: .travel, imageName: "sun.max", title: "여행")
                    
                    Spacer()
                    
                    // 프로필
                    tabBarItem(tab: .profile, imageName: "person", title: "프로필")
                    
                    Spacer()
                }
                .frame(height: 60)
                .background(Color.black)
            }
        }
    }
    
    // MARK: - TabBarItem View
    private func tabBarItem(tab: Tab, imageName: String, title: String) -> some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(selectedTab == tab ? .white : .gray)
                
                if selectedTab == tab {
                    Text(title)
                        .font(.caption)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
