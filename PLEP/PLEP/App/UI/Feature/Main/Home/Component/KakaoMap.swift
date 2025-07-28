//
// KakaoMap.swift
// PLEP
//
// Created by 이다경 on 7/27/25.
//

import SwiftUI
import KakaoMapsSDK

struct KakaoMapView: UIViewRepresentable {
    @Binding var draw: Bool

    func makeCoordinator() -> KakaoMapCoordinator {
        KakaoMapCoordinator()
    }

    func makeUIView(context: Context) -> KMViewContainer {
        let viewContainer = KMViewContainer()
        context.coordinator.createController(viewContainer)
        context.coordinator.controller?.prepareEngine()
        return viewContainer
    }

    func updateUIView(_ uiView: KMViewContainer, context: Context) {
        if draw {
            context.coordinator.controller?.activateEngine()
        } else {
            context.coordinator.controller?.resetEngine()
        }
    }

    static func dismantleUIView(_ uiView: KMViewContainer, coordinator: KakaoMapCoordinator) {
        coordinator.controller?.resetEngine()
    }

    class KakaoMapCoordinator: NSObject, MapControllerDelegate {
        var controller: KMController?

        func createController(_ view: KMViewContainer) {
            controller = KMController(viewContainer: view)
            controller?.delegate = self
        }

        @objc func addViews() {
            let defaultPosition = MapPoint(longitude: 127.027636, latitude: 37.497950)
            let mapviewInfo = MapviewInfo(
                viewName: "mapview",
                viewInfoName: "map",
                defaultPosition: defaultPosition,
                defaultLevel: 7)
            controller?.addView(mapviewInfo)
        }

        func addViewSucceeded(_ viewName: String, viewInfoName: String) {
            print("지도 추가 성공: \(viewName) / \(viewInfoName)")
            if let mapView = controller?.getView(viewName) as? KakaoMap {
                mapView.showOverlay("roadview_line")
            }
        }

        func addViewFailed(_ viewName: String, viewInfoName: String) {}
        func containerDidResized(_ size: CGSize) {}
        func authenticationFailed(_ errorCode: Int, desc: String) {
            print("KakaoMap Auth failed: \(errorCode) \(desc)")
        }
    }
}
