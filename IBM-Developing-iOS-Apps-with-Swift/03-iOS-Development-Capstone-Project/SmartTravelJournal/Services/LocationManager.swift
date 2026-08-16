//
//  LocationManager.swift
//  SmartTravelJournal
//
//  Created by Valentyn Verovkin on 09.08.2026.
//

import Foundation
import CoreLocation

@MainActor
@Observable
final class LocationManager: NSObject, CLLocationManagerDelegate {

    private let manager = CLLocationManager()

    var currentCoordinate: CLLocationCoordinate2D?
    var authorizationStatus: CLAuthorizationStatus = .notDetermined

    override init() {
        super.init()

        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }

    func startUpdating() {
        manager.startUpdatingLocation()
    }

    func stopUpdating() {
        manager.stopUpdatingLocation()
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        currentCoordinate = location.coordinate
    }

    func locationManagerDidChangeAuthorization(
        _ manager: CLLocationManager
    ) {
        authorizationStatus = manager.authorizationStatus

        if authorizationStatus == .authorizedWhenInUse {
            startUpdating()
        }
    }
}
