//
// KakaoMap.swift
// PLEP
//
// Created by 이다경 on 7/27/25.
//

import SwiftUI
import KakaoMapsSDK
import CoreLocation

struct KakaoMapView: UIViewRepresentable {
    @StateObject private var locationManager = LocationManager()

    func makeCoordinator() -> KakaoMapCoordinator {
        KakaoMapCoordinator(locationManager: locationManager)
    }

    func makeUIView(context: Context) -> KMViewContainer {
        let viewContainer = KMViewContainer()
        let coordinator = context.coordinator
        coordinator.createController(viewContainer)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            guard let controller = coordinator.controller else {
                print("❗️controller is nil before prepareEngine")
                return
            }
            controller.prepareEngine()
            controller.activateEngine()
            coordinator.addViews()
        }

        return viewContainer
    }

    func updateUIView(_ uiView: KMViewContainer, context: Context) {}

    static func dismantleUIView(_ uiView: KMViewContainer, coordinator: KakaoMapCoordinator) {
        if let controller = coordinator.controller {
            controller.pauseEngine()
            controller.resetEngine()
            print("Engine paused and reset on dismantle")
        } else {
            print("controller already nil on dismantle")
        }
    }

    class KakaoMapCoordinator: NSObject, MapControllerDelegate, CLLocationManagerDelegate {
        var controller: KMController?
        var locationManager: LocationManager

        init(locationManager: LocationManager) {
            self.locationManager = locationManager
            super.init()
            self.locationManager.manager.delegate = self
            self.locationManager.manager.requestWhenInUseAuthorization()
            self.locationManager.manager.startUpdatingLocation()
        }

        func createController(_ view: KMViewContainer) {
            controller = KMController(viewContainer: view)
            controller?.delegate = self
            print("controller created")
        }

        func addViews() {
            let defaultPosition = MapPoint(longitude: 127.027636, latitude: 37.497950)
            let mapviewInfo = MapviewInfo(
                viewName: "mapview",
                viewInfoName: "map",
                defaultPosition: defaultPosition,
                defaultLevel: 7
            )
            controller?.addView(mapviewInfo)
            print("addView called")
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            print("사용자 위치 업데이트: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        }

        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("위치 업데이트 실패: \(error.localizedDescription)")
        }

        func addViewSucceeded(_ viewName: String, viewInfoName: String) {
            print("지도 추가 성공: \(viewName) / \(viewInfoName)")
        }

        func addViewFailed(_ viewName: String, viewInfoName: String) {
            print("지도 추가 실패: \(viewName) / \(viewInfoName)")
        }

        func authenticationFailed(_ errorCode: Int, desc: String) {
            print("KakaoMap 인증 실패: \(errorCode), \(desc)")
        }

        func containerDidResized(_ size: CGSize) {
            print("지도 뷰 리사이즈됨: \(size)")
        }

        deinit {
            print("KakaoMapCoordinator deinitialized")
            locationManager.manager.stopUpdatingLocation()
        }
    }

    class LocationManager: NSObject, ObservableObject {
        let manager = CLLocationManager()

        override init() {
            super.init()
        }
    }
}
