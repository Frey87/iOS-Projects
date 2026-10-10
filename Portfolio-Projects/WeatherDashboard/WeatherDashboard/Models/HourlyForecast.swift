//
//  HourlyForecast.swift
//  WeatherDashboard
//
//  Created by Valentyn Verovkin on 11.07.2026.
//

import Foundation

struct HourlyForecast: Identifiable {
    let id = UUID()
    let hour: String
    let icon: String
    let temperature: Int
}

