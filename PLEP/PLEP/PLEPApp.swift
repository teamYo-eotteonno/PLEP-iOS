//
//  PLEPApp.swift
//  PLEP
//
//  Created by 이다경 on 4/3/25.
//

import SwiftUI

@main
struct PLEPApp: App {
    var body: some Scene {
        WindowGroup {
            PLEPButton(
                title: "Label",
                type: .neutral,
                size: .medium,
                enabled: true,
                color: .dark,
                icon: true
            ) {
                print("Button tapped!")
            }
        }
    }
}
