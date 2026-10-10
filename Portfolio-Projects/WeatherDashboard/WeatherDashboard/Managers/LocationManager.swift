//
//  LocationManager.swift
//  WeatherDashboard
//
//  Created by Valentyn Verovkin on 12.07.2026.
//
import Foundation
import CoreLocation
import Observation

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {

    private let manager = CLLocationManager()

    var userLocation: CLLocationCoordinate2D?

    var authorizationStatus: CLAuthorizationStatus =
        .notDetermined

    override init() {

        super.init()

        manager.delegate = self

        manager.desiredAccuracy =
            kCLLocationAccuracyKilometer
    }

    func requestPermission() {

        manager.requestWhenInUseAuthorization()
    }

    func requestLocation() {

        manager.requestLocation()
    }

    func locationManagerDidChangeAuthorization(
        _ manager: CLLocationManager
    ) {

        authorizationStatus = manager.authorizationStatus

        if authorizationStatus == .authorizedWhenInUse {

            manager.requestLocation()
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {

        userLocation = locations.last?.coordinate
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {

        print(error.localizedDescription)
    }
}

