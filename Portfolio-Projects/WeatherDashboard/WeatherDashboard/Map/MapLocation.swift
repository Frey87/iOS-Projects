//
//  MapLocation.swift
//  WeatherDashboard
//
//  Created by Valentyn Verovkin on 12.07.2026.
//

import Foundation
import CoreLocation

struct MapLocation: Identifiable {

    let id = UUID()

    let city: String
    let temperature: Int
    let condition: String

    let latitude: Double
    let longitude: Double

    var coordinate: CLLocationCoordinate2D {

        CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
    }
}
