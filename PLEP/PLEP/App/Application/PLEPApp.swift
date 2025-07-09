//
//  PLEPApp.swift
//  PLEP
//
//  Created by 이다경 on 4/3/25.
//

import SwiftUI
import FlowKit

@main
struct PLEPApp: App {
    @StateObject private var authManager = AuthManager.shared
    
    var body: some Scene {
        WindowGroup {
            Group {
//                if (try? authManager.isLoggedIn.value()) == true {
//                    FlowPresenter(rootView: HomeView())
//                } else {
//                    FlowPresenter(rootView: LoginViewDi().loginView)
                    FlowPresenter(rootView: OnboardingFirstView())
//                }
            }
            .edgesIgnoringSafeArea(.all)
            .environmentObject(authManager)
            .onAppear {
                _ = UINavigationController()
            }
            .onAppear {
                let access = AuthCache.live.getToken(of: .Token)
                let refresh = AuthCache.live.getToken(of: .refreshToken)
                print("accessToken: \(access ?? "없음")")
                print("refreshToken: \(refresh ?? "없음")")
            }
        }
    }
}
