////
////  KMViewController.swift
////  PLEP
////
////  Created by 이다경 on 7/27/25.
////
//
//import UIKit
//import KakaoMapsSDK_SPM
//import KakaoSDKCommon
//
//class KMMapViewController: UIViewController, MapControllerDelegate {
//    private var mapContainer: KMViewContainer!
//    private var mapController: KMController!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        mapContainer = KMViewContainer(frame: view.bounds)
//        mapContainer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.addSubview(mapContainer)
//
//        mapController = KMController(viewContainer: mapContainer)
//        mapController.delegate = self
//        mapController.prepareEngine()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        if !mapController.isEngineActive {
//            mapController.activateEngine()
//        }
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        mapController.pauseEngine()
//    }
//
//    deinit {
//        mapController.resetEngine()
//    }
//
//    // MapControllerDelegate 구현
//    func addViews() {
//        let defaultPos = MapPoint(longitude: 127.027636, latitude: 37.497950)
//        let mapInfo = MapviewInfo(viewName: "mainMap",
//                                  viewInfoName: "map0",
//                                  defaultPosition: defaultPos,
//                                  defaultLevel: 5)
//        mapController.addView(mapInfo)
//    }
//    func authenticationFailed(_ errorCode: Int, desc: String) {
//        print("Auth failed (\(errorCode)): \(desc)")
//    }
//    func addViewSucceeded(_: String, viewInfoName _: String) { }
//    func addViewFailed(_: String, viewInfoName _: String) { }
//    func containerDidResized(_: CGSize) { }
//}
