//
//  HomeView.swift
//  PLEP
//
//  Created by 이다경 on 5/29/25.
//

import SwiftUI
import FlowKit

struct HomeView: View {
    @State private var selectedTab: Tab = .home
    @State private var draw: Bool = true
    
    enum Tab {
        case home
        case calendar
        case aiSearch
        case travel
        case profile
    }
    
    var body: some View {
        ZStack {
            DisablePopGesture()
            contentView
            
            VStack(spacing: 0) {
                Spacer()
                Divider()
                    .frame(height: 1)
                    .background(Color.black.opacity(0.25))
                HStack {
                    Spacer()
                    
                    tabBarItem(tab: .home, imageName: Asset.Home.default, selectedImageName: Asset.Home.tap, title: "홈")
                    
                    Spacer()
                    
                    tabBarItem(tab: .calendar, imageName: Asset.Calendar.default, selectedImageName: Asset.Calendar.tap, title: "일정")
                    
                    VStack(spacing: 5) {
                        ZStack {
                            Circle()
                                .foregroundColor(selectedTab == .aiSearch ? .p[500] : .g[100])
                                .frame(width: 65, height: 65)
                            Button(action: {
                                selectedTab = .aiSearch
                            }) {
                                Image(selectedTab == .aiSearch ? Asset.Search.tap : Asset.Search.default)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                        }
                        
                        Text("AI 서칭")
                            .textStyle.title.pre
                            .foregroundColor(.p[500])
                            .opacity(selectedTab == .aiSearch ? 1 : 0)
                    }
                    .padding(.top, -55)
                    .padding(.horizontal)
                    
                    tabBarItem(tab: .travel, imageName: Asset.Sun.default, selectedImageName: Asset.Sun.tap, title: "여행")
                    
                    Spacer()
                    
                    tabBarItem(tab: .profile, imageName: Asset.Profile.default, selectedImageName: Asset.Profile.tap, title: "프로필")
                    
                    Spacer()
                }
                .padding(.top, 11)
                .padding(.bottom, 44)
                .background(Color.g[0])
            }
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch selectedTab {
        case .home:
            ZStack {
                KakaoMapView(draw: $draw)
                    .ignoresSafeArea()
                    .edgesIgnoringSafeArea(.all)
                MainBottomSheet(showButton: true) { PlacesListSheet() }
            }
        case .calendar:
            FlowPresenter(rootView: MainCalendarViewDi().maincalendarView)
        case .aiSearch:
            FlowPresenter(rootView: SearchingView())
        case .travel:
            FlowPresenter(rootView: TravelFeedViewDi().travelfeedView)
                .padding(.bottom, 100)
        case .profile:
            FlowPresenter(rootView: ProfileViewDi().profileView)
//                .ignoresSafeArea()
                .padding(.bottom, 80)
        }
    }
    
    private func tabBarItem(tab: Tab, imageName: String, selectedImageName: String, title: String) -> some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack(spacing: 3) {
                Image(selectedTab == tab ? selectedImageName : imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                
                Text(title)
                    .textStyle.title.pre
                    .foregroundColor(.p[500])
                    .opacity(selectedTab == tab ? 1 : 0)
            }
        }
    }
}
