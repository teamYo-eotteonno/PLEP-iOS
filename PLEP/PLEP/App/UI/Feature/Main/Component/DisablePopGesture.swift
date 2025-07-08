//
//  DisablePopGesture.swift
//  PLEP
//
//  Created by 이다경 on 7/8/25.
//

import Foundation
import SwiftUI

struct DisablePopGesture: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        DispatchQueue.main.async {
            controller.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
