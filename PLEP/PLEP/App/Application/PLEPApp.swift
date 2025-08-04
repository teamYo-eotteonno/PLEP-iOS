//
//  PLEPApp.swift
//  PLEP
//
//  Created by 이다경 on 4/3/25.
//

import SwiftUI
import FlowKit
import KakaoSDKCommon
import KakaoMapsSDK
import CoreLocation

@main
struct PLEPApp: App {
    @StateObject private var authManager = AuthManager.shared
    private let locationManager = LocationManager()

    init() {
        SDKInitializer.InitSDK(appKey: "653216cff32758398d4fdcf80225c8bc")
        _ = locationManager
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                if authManager.isLoggedIn {
                    FlowPresenter(rootView: HomeView())
                } else {
//                    FlowPresenter(rootView: OnboardingFirstView())
//                    FlowPresenter(rootView: JoinViewDi().firstView(joinViewDi: JoinViewDi()))
                    FlowPresenter(rootView: LoginViewDi().loginView)
                }
            }
            .edgesIgnoringSafeArea(.all)
            .environmentObject(authManager)
            .onAppear {
                authManager.checkLoginStatus()

                let access = AuthCache.live.getToken(of: .Token)
                let refresh = AuthCache.live.getToken(of: .refreshToken)
                print("accessToken: \(access ?? "없음")")
                print("refreshToken: \(refresh ?? "없음")")
            }
            .onReceive(NotificationCenter.default.publisher(for: .didLogout)) { _ in
            }
        }
    }
}
