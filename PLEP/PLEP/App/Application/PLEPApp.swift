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
    var body: some Scene {
        WindowGroup {
            FlowPresenter(rootView: OnboardingFirstView())
                .onAppear {
                    _ = UINavigationController()
                }
                .edgesIgnoringSafeArea(.all)
        }
    }
}
