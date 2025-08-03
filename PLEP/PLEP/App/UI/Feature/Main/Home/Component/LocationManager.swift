//
//  KMViewController.swift
//  PLEP
//
//  Created by 이다경 on 7/27/25.
//

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()

    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }
}
