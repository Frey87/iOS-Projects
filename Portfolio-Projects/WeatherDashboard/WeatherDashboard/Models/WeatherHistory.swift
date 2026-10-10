//
//  WeatherHistory.swift
//  WeatherDashboard
//
//  Created by Valentyn Verovkin on 12.07.2026.
//

import Foundation
import SwiftData

@Model
class WeatherHistory {

    var temperature: Double
    var condition: String
    var date: Date
    var location: SavedLocation?

    init(temperature: Double, condition: String, date: Date) {
        self.temperature = temperature
        self.condition   = condition
        self.date        = date
    }
}
