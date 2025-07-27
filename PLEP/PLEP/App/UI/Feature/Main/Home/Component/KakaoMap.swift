//
// KakaoMap.swift
// PLEP
//
// Created by 이다경 on 7/27/25.
//

import SwiftUI
import KakaoMapsSDK

struct KakaoMap: View {
    var body: some View {
        KakaoMapViewControllerRepresentable()
            .edgesIgnoringSafeArea(.all)
    }
}

struct KakaoMapViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> KakaoMapViewController {
        let vc = KakaoMapViewController()
        return vc
    }

    func updateUIViewController(_ uiViewController: KakaoMapViewController, context: Context) {
        // 필요 시 상태 기반 업데이트
    }
}

class KakaoMapViewController: UIViewController, MapControllerDelegate {
    private var mapContainer: KMViewContainer!
    private var mapController: KMController!

    override func viewDidLoad() {
        super.viewDidLoad()

//        // AppKey 설정 (필수)
//        if let path = Bundle.main.path(forResource: "AppKey", ofType: "plist"),
//           let dict = NSDictionary(contentsOfFile: path),
//           let appKey = dict["APP_KEY"] as? String {
//            KMController.setAppKey(appKey)
//        } else {
//            print("❌ AppKey.plist에서 APP_KEY를 찾을 수 없습니다.")
//        }

        mapContainer = KMViewContainer(frame: view.bounds)
        view.addSubview(mapContainer)

        mapController = KMController(viewContainer: mapContainer)
        mapController.delegate = self
        mapController.prepareEngine()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if mapController.isEngineActive == false {
            mapController.activateEngine()  // 렌더링 시작
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mapController.pauseEngine()       // 렌더링 일시 정지
    }

    deinit {
        mapController.resetEngine()       // 엔진 리셋 (정리)
    }

    // MapControllerDelegate
    func addViews() {
        let defaultPos = MapPoint(longitude: 127.027636, latitude: 37.497950)
        let mapInfo = MapviewInfo(
            viewName: "mainMap",
            viewInfoName: "map0",
            defaultPosition: defaultPos,
            defaultLevel: 5
        )
        mapController.addView(mapInfo)
    }

    func addViewSucceeded(_ viewName: String, viewInfoName: String) {
        // 지도 뷰 추가 성공 시 추가 동작 가능
    }

    func addViewFailed(_ viewName: String, viewInfoName: String) {
        print("addViewFailed: \(viewName), \(viewInfoName)")
    }

    func containerDidResized(_ size: CGSize) {
        // 컨테이너 크기 다변경 시 처리
    }

    func authenticationFailed(_ errorCode: Int, desc: String) {
        print("Auth failed: \(errorCode), \(desc)")
    }
}

//struct KakaoMap: View {
//    var body: some View {
//        KakaoMapViewControllerRepresentable()
//            .edgesIgnoringSafeArea(.all)
//    }
//}
//
//struct KakaoMapViewControllerRepresentable: UIViewControllerRepresentable {
//    func makeUIViewController(context: Context) -> KMMapViewController {
//        return KMMapViewController()
//    }
//
//    func updateUIViewController(_ uiViewController: KMMapViewController, context: Context) {
//        // 필요하다면 상태 기반 업데이트 로직 구현
//    }
//}
