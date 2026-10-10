//
//  SavedLocation.swift
//  WeatherDashboard
//
//  Created by Valentyn Verovkin on 12.07.2026.
//

import Foundation
import SwiftData

@Model
class SavedLocation {

    var name: String
    var latitude: Double
    var longitude: Double
    var dateAdded: Date

    @Relationship(deleteRule: .cascade)
    var weatherHistory: [WeatherHistory] = []

    init(name: String, latitude: Double, longitude: Double) {
        self.name      = name
        self.latitude  = latitude
        self.longitude = longitude
        self.dateAdded = .now
    }
}

